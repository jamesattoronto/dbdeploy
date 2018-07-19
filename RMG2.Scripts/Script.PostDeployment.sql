/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

/* just make change to triger rebuild, try again,*/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
:r ".\RMG_BOSS2_initial_scripts\spBOSS_ConfigurationCreateSingle.sql"
GO