/*
Post-Deployment Scipt Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build scipt.		
 Use SQLCMD syntax to include a file in the post-deployment scipt.			
 Example:r       :r  .\myfile.sql"								
 Use SQLCMD syntax to efeence a vaiable in the post-deployment scipt.		
 Example:r       :r setva TableName MyTable							
               SELECT * FOM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
GO
:r ".\JIRAs\SCHED-1847\SCHED-1847_CreateTables.sql"
GO
:r ".\JIRAs\SCHED-1847\SCHED-1847_CommissionsProc.sql"
GO
