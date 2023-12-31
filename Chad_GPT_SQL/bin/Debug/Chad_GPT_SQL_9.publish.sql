﻿/*
Deployment script for Chad_GPT_SQL

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Chad_GPT_SQL"
:setvar DefaultFilePrefix "Chad_GPT_SQL"
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
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating database $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


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
    [Id]       INT           IDENTITY (1, 1) NOT NULL,
    [TypeName] NVARCHAR (10) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Table [dbo].[User]...';


GO
CREATE TABLE [dbo].[User] (
    [Id]       INT           IDENTITY (1, 1) NOT NULL,
    [UserName] NVARCHAR (40) NOT NULL,
    [Password] NVARCHAR (40) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[Answer]...';


GO
ALTER TABLE [dbo].[Answer]
    ADD FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[Category] ([Id]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[Answer]...';


GO
ALTER TABLE [dbo].[Answer]
    ADD FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[User] ([Id]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[Category]...';


GO
ALTER TABLE [dbo].[Category]
    ADD FOREIGN KEY ([Type]) REFERENCES [dbo].[Type] ([Id]);


GO
PRINT N'Creating Foreign Key unnamed constraint on [dbo].[Image]...';


GO
ALTER TABLE [dbo].[Image]
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
ConnectionString: "Data Source=DESKTOP-IS402U0\SQLEXPRESS;Integrated Security=True;Persist Security Info=False;Pooling=False;MultipleActiveResultSets=False;Connect Timeout=60;Encrypt=False;TrustServerCertificate=False"
--------------------------------------------------------------------------------------
*/
begin
    IF NOT EXISTS (SELECT 1 FROM dbo.[Type])
    INSERT INTO dbo.[Type] (TypeName)
    VALUES ('Image'),('Question');
    IF NOT EXISTS (SELECT 1 FROM dbo.[Category])
    INSERT INTO dbo.[Category] (CategoryName, [Type])
    VALUES ('Misc. Images', 1
    ),('Misc. Questions', 2);
    IF NOT EXISTS (SELECT 1 FROM dbo.[User])
    INSERT INTO dbo.[User] (UserName, [Password])
    VALUES ('Chad_GPT','foo');
end;



GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Update complete.';


GO
