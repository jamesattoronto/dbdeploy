CREATE PROCEDURE [dbo].[spBOSS_ConfigurationCreateSingle]
		@new_bcd_module VARCHAR(100),
		@defaultValue VARCHAR(100) = '(not set)',
		@BCM_Servername VARCHAR(100) = NULL ,
		@DBName VARCHAR(100) = NULL ,
		@BCM_Lender VARCHAR(100) = NULL ,
		@BCM_Environment VARCHAR(100) = NULL
AS 
		DECLARE @bcm_id INT

		IF ( @BCM_Servername IS NULL ) 
			BEGIN
				SET @BCM_Servername = @@SERVERNAME
		END

		IF ( @DBName IS NULL ) 
			BEGIN
				SET @DBName = DB_NAME()
			END
 
		IF ( @BCM_Lender IS NULL ) 
			BEGIN
				SET @BCM_Lender = dbo.udfBOSS_GetLender()
			END

		IF ( @BCM_Environment IS NULL ) 
			BEGIN
				SET @BCM_Environment = dbo.udfBOSS_GetEnvironment()  
			END
		
		DECLARE @id INT
		DECLARE @rowCnt INT

		SELECT @bcm_id = BCM_ID
		FROM    dbo.ioz_BOSS_ConfigurationMaster
		WHERE   BCM_Environment = @BCM_Environment
				AND BCM_Lender = @BCM_Lender
				AND BCM_Servername = @BCM_Servername
				AND BCM_DBname = @DBName

		SET @rowCnt = @@ROWCOUNT

		IF ( @rowCnt <> 1 ) 
			BEGIN
				DECLARE @errorText VARCHAR(200)
				SET @errorText = 'Value was not updated: the query returned '
					+ CAST(@rowCnt AS VARCHAR(10)) + ' rows'
			
				RAISERROR				
					(@errorText,
					16, -- Severity.
					1) -- Second substitution argument.
			END

		ELSE 
			BEGIN            
				IF NOT EXISTS ( SELECT  BCD_ID
								FROM    ioz_BOSS_Configuration
								WHERE   BCD_IDLink_BCM = @bcm_id
										AND BCD_Module = @new_bcd_module ) 
					BEGIN
						PRINT 'Creating new ' + @new_bcd_module
                
						INSERT  INTO ioz_BOSS_Configuration
								( BCD_IDLink_BCM ,
								  BCD_Module ,
								  BCD_Setting ,
								  BCD_Created ,
								  BCD_modified
								)
						VALUES  ( @bcm_id ,
								  @new_bcd_module ,
								  @defaultValue ,
								  GETDATE() ,
								  GETDATE()
								)
					END 
		END
GO


