﻿/*
Deployment script for UserDB

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "UserDB"
:setvar DefaultFilePrefix "UserDB"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
/*
The column [dbo].[User].[FirstName] is being dropped, data loss could occur.

The column [dbo].[User].[LastName] is being dropped, data loss could occur.

The column [dbo].[User].[Password] on table [dbo].[User] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.

The column [dbo].[User].[UserName] on table [dbo].[User] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.
*/

IF EXISTS (select top 1 1 from [dbo].[User])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'Altering Table [dbo].[User]...';


GO
ALTER TABLE [dbo].[User] DROP COLUMN [FirstName], COLUMN [LastName];


GO
ALTER TABLE [dbo].[User]
    ADD [UserName] NVARCHAR (40) NOT NULL,
        [Password] NVARCHAR (40) NOT NULL;


GO
PRINT N'Creating Table [dbo].[Answer]...';


GO
CREATE TABLE [dbo].[Answer] (
    [Id]         INT            IDENTITY (1, 1) NOT NULL,
    [Prompt]     NVARCHAR (MAX) NOT NULL,
    [Answer]     NVARCHAR (MAX) NOT NULL,
    [CategoryId] INT            NULL,
    [CreatedBy]  INT            NULL,
    [CreatedOn]  DATE           NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Table [dbo].[Category]...';


GO
CREATE TABLE [dbo].[Category] (
    [Id]           INT            IDENTITY (1, 1) NOT NULL,
    [CategoryName] NVARCHAR (100) NOT NULL,
    [Type]         INT            NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Table [dbo].[Image]...';


GO
CREATE TABLE [dbo].[Image] (
    [Id]         INT            IDENTITY (1, 1) NOT NULL,
    [Prompt]     NVARCHAR (MAX) NULL,
    [URL]        NVARCHAR (MAX) NULL,
    [CategoryId] INT            NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Table [dbo].[Type]...';


GO
CREATE TABLE [dbo].[Type] (
    [Id]       INT          NOT NULL,
    [TypeName] VARCHAR (10) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[Answer]...';


GO
ALTER TABLE [dbo].[Answer] WITH NOCHECK
    ADD FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[Category] ([Id]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[Answer]...';


GO
ALTER TABLE [dbo].[Answer] WITH NOCHECK
    ADD FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[User] ([Id]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[Category]...';


GO
ALTER TABLE [dbo].[Category] WITH NOCHECK
    ADD FOREIGN KEY ([Type]) REFERENCES [dbo].[Type] ([Id]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[Image]...';


GO
ALTER TABLE [dbo].[Image] WITH NOCHECK
    ADD FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[Category] ([Id]);


GO
PRINT N'Creating Procedure [dbo].[DeleteAnswer]...';


GO
CREATE PROCEDURE [dbo].[DeleteAnswer]
	@Id INT
AS
begin
	DELETE FROM dbo.[Answer]
	WHERE Id = @Id
end
GO
PRINT N'Creating Procedure [dbo].[DeleteImage]...';


GO
CREATE PROCEDURE [dbo].[DeleteImage]
	@Id INT
AS
begin
	DELETE FROM dbo.[Image]
	WHERE Id = @Id
end
GO
PRINT N'Creating Procedure [dbo].[DeleteUser]...';


GO
CREATE PROCEDURE [dbo].[DeleteUser]
	@Id INT
AS
begin
	DELETE FROM dbo.[User]
	WHERE Id = @Id
end
GO
PRINT N'Creating Procedure [dbo].[GetAnswer]...';


GO
CREATE PROCEDURE [dbo].[GetAnswer]
	@Id INT
AS
begin
	SELECT 1 FROM dbo.[Answer]
	WHERE Id = @Id
end
GO
PRINT N'Creating Procedure [dbo].[GetAnswerByCategory]...';


GO
CREATE PROCEDURE [dbo].[GetAnswerByCategory]
	@CategoryId INT
AS
begin
	SELECT 
		Id,
		Prompt,
		Answer,
		CategoryId,
		CreatedBy,
		CreatedOn

	FROM dbo.[Answer]
	WHERE CategoryId = @CategoryId
end
GO
PRINT N'Creating Procedure [dbo].[GetAnswers]...';


GO
CREATE PROCEDURE [dbo].[GetAnswers]
	
AS
begin
	SELECT * FROM dbo.[Answer]
end
GO
PRINT N'Creating Procedure [dbo].[GetImage]...';


GO
CREATE PROCEDURE [dbo].[GetImage]
	@Id INT
AS
begin
	SELECT 1 FROM dbo.[Image]
	WHERE Id = @Id
end
GO
PRINT N'Creating Procedure [dbo].[GetImageByCategory]...';


GO
CREATE PROCEDURE [dbo].[GetImageByCategory]
	@CategoryId INT
AS
begin
	SELECT Id, Prompt, [URL], CategoryId FROM dbo.[Image]
	WHERE CategoryId = @CategoryId
	ORDER BY Id
end
GO
PRINT N'Creating Procedure [dbo].[GetImages]...';


GO
CREATE PROCEDURE [dbo].[GetImages]
	
AS
begin
	SELECT * FROM dbo.[Image]
end
GO
PRINT N'Creating Procedure [dbo].[GetUser]...';


GO
CREATE PROCEDURE [dbo].[GetUser]
	@Id INT
AS
begin
	SELECT 1 FROM dbo.[User]
	WHERE Id = @Id
end
GO
PRINT N'Creating Procedure [dbo].[GetUsers]...';


GO
CREATE PROCEDURE [dbo].[GetUsers]

AS
begin
	SELECT * FROM dbo.[User]
end
GO
PRINT N'Creating Procedure [dbo].[InsertAnswer]...';


GO
CREATE PROCEDURE [dbo].[InsertAnswer]
	@Prompt NVARCHAR(MAX),
	@Answer NVARCHAR(MAX),
	@CategoryId INT,
	@CreatedBy INT,
	@CreatedOn DATE
	
AS
begin
	INSERT INTO dbo.Answer (
	Prompt, 
	Answer, 
	CategoryId, 
	CreatedBy, 
	CreatedOn
	)
	VALUES (
		@Prompt,
		@Answer,
		@CategoryId,
		@CreatedBy,
		@CreatedOn
	)
end
GO
PRINT N'Creating Procedure [dbo].[InsertCategory]...';


GO
CREATE PROCEDURE [dbo].[InsertCategory]
	@CategoryName NVARCHAR(100),
	@Type INT
AS

begin
	INSERT INTO dbo.Category (CategoryName, [Type])
	VALUES(
		@CategoryName,
		@Type
	)
end
GO
PRINT N'Creating Procedure [dbo].[InsertImage]...';


GO
CREATE PROCEDURE [dbo].[InsertImage]
	@Prompt NVARCHAR(MAX),
	@URL NVARCHAR(MAX),
	@CategoryId INT
AS
begin
	INSERT INTO dbo.[Image] (Prompt, [URL], CategoryId)
	VALUES (
		@Prompt,
		@URL,
		@CategoryId
	)
end
GO
PRINT N'Creating Procedure [dbo].[InsertUser]...';


GO
CREATE PROCEDURE [dbo].[InsertUser]
	@UserName NVARCHAR(40),
	@Password NVARCHAR(40)
AS
begin 
	INSERT INTO dbo.[User] (UserName, [Password])
	VALUES(
		@UserName,
		@Password
	)
end
GO
PRINT N'Creating Procedure [dbo].[UpdateUser]...';


GO
CREATE PROCEDURE [dbo].[UpdateUser]
	@Id INT,
	@UserName NVARCHAR(40),
	@Password NVARCHAR(40)
AS
begin
	UPDATE dbo.[User] 
	SET UserName = @UserName,
	[Password] = @Password
	WHERE Id = @Id
end
GO
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
IF NOT EXISTS (SELECT 1 FROM dbo.[User])
begin
    INSERT INTO dbo.[User] (UserName, [Password])
    VALUES ('Chad_GPT','foo');
end;
IF NOT EXISTS (SELECT 1 FROM dbo.[Type])
begin
    INSERT INTO dbo.[Type] (TypeName)
    VALUES ('Image'),('Question')
end
IF NOT EXISTS (SELECT 1 FROM dbo.[Category])
begin
    INSERT INTO dbo.[Category] (CategoryName, [Type])
    VALUES ('Misc. Images', (
        SELECT 1 FROM dbo.[Type]
        WHERE TypeName = 'Image')
    ),('Misc. Questions', (
            SELECT 1 FROM dbo.[Type]
            WHERE TypeName = 'Question'
        
        )
    )
end
GO

GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
CREATE TABLE [#__checkStatus] (
    id           INT            IDENTITY (1, 1) PRIMARY KEY CLUSTERED,
    [Schema]     NVARCHAR (256),
    [Table]      NVARCHAR (256),
    [Constraint] NVARCHAR (256)
);

SET NOCOUNT ON;

DECLARE tableconstraintnames CURSOR LOCAL FORWARD_ONLY
    FOR SELECT SCHEMA_NAME([schema_id]),
               OBJECT_NAME([parent_object_id]),
               [name],
               0
        FROM   [sys].[objects]
        WHERE  [parent_object_id] IN (OBJECT_ID(N'dbo.Answer'), OBJECT_ID(N'dbo.Category'), OBJECT_ID(N'dbo.Image'))
               AND [type] IN (N'F', N'C')
                   AND [object_id] IN (SELECT [object_id]
                                       FROM   [sys].[check_constraints]
                                       WHERE  [is_not_trusted] <> 0
                                              AND [is_disabled] = 0
                                       UNION
                                       SELECT [object_id]
                                       FROM   [sys].[foreign_keys]
                                       WHERE  [is_not_trusted] <> 0
                                              AND [is_disabled] = 0);

DECLARE @schemaname AS NVARCHAR (256);

DECLARE @tablename AS NVARCHAR (256);

DECLARE @checkname AS NVARCHAR (256);

DECLARE @is_not_trusted AS INT;

DECLARE @statement AS NVARCHAR (1024);

BEGIN TRY
    OPEN tableconstraintnames;
    FETCH tableconstraintnames INTO @schemaname, @tablename, @checkname, @is_not_trusted;
    WHILE @@fetch_status = 0
        BEGIN
            PRINT N'Checking constraint: ' + @checkname + N' [' + @schemaname + N'].[' + @tablename + N']';
            SET @statement = N'ALTER TABLE [' + @schemaname + N'].[' + @tablename + N'] WITH ' + CASE @is_not_trusted WHEN 0 THEN N'CHECK' ELSE N'NOCHECK' END + N' CHECK CONSTRAINT [' + @checkname + N']';
            BEGIN TRY
                EXECUTE [sp_executesql] @statement;
            END TRY
            BEGIN CATCH
                INSERT  [#__checkStatus] ([Schema], [Table], [Constraint])
                VALUES                  (@schemaname, @tablename, @checkname);
            END CATCH
            FETCH tableconstraintnames INTO @schemaname, @tablename, @checkname, @is_not_trusted;
        END
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH

IF CURSOR_STATUS(N'LOCAL', N'tableconstraintnames') >= 0
    CLOSE tableconstraintnames;

IF CURSOR_STATUS(N'LOCAL', N'tableconstraintnames') = -1
    DEALLOCATE tableconstraintnames;

SELECT N'Constraint verification failed:' + [Schema] + N'.' + [Table] + N',' + [Constraint]
FROM   [#__checkStatus];

IF @@ROWCOUNT > 0
    BEGIN
        DROP TABLE [#__checkStatus];
        RAISERROR (N'An error occurred while verifying constraints', 16, 127);
    END

SET NOCOUNT OFF;

DROP TABLE [#__checkStatus];


GO
PRINT N'Update complete.';


GO
