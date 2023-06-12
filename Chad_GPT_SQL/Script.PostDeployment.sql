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



