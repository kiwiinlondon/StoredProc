SET IDENTITY_INSERT ApplicationUser ON

INSERT INTO [Keeley].[dbo].[ApplicationUser]
	([UserID],[FMPersID],[Name],[Email],[WindowsLogin],[StartDt],[UpdateUserID])
     VALUES
           (1,null,'Geoff Poore','g.poore@odey.com','OAM\geoffp',GETDATE(),1)

SET IDENTITY_INSERT ApplicationUser OFF


INSERT INTO [Keeley].[dbo].[KeeleyType]
           ([Name],[AssemblyName],[TypeName],[StartDt],[UpdateUserID])
     VALUES
           ('Region','Odey.Framework.Keeley.Entities','Odey.Framework.Keeley.Entities.Region',GETDATE(),1)

INSERT INTO [Keeley].[dbo].[KeeleyType]
           ([Name],[AssemblyName],[TypeName],[StartDt],[UpdateUserID])
     VALUES
           ('Country','Odey.Framework.Keeley.Entities','Odey.Framework.Keeley.Entities.Country',GETDATE(),1)
           
INSERT INTO [Keeley].[dbo].[KeeleyType]
           ([Name],[AssemblyName],[TypeName],[StartDt],[UpdateUserID])
     VALUES
           ('Issuer','Odey.Framework.Keeley.Entities','Odey.Framework.Keeley.Entities.Issuer',GETDATE(),1)           

INSERT INTO [Keeley].[dbo].[KeeleyType]
           ([Name],[AssemblyName],[TypeName],[StartDt],[UpdateUserID])
     VALUES
           ('Exchange','Odey.Framework.Keeley.Entities','Odey.Framework.Keeley.Entities.Exchange',GETDATE(),1)           

INSERT INTO [Keeley].[dbo].[KeeleyType]
           ([Name],[AssemblyName],[TypeName],[StartDt],[UpdateUserID])
     VALUES
           ('LegalEntity','Odey.Framework.Keeley.LegalEntity','Odey.Framework.Keeley.Entities.LegalEntity',GETDATE(),1) 
	
INSERT INTO [Keeley].[dbo].[IdentifierType]
           ([FMIdentType],[Name],[StartDt],[UpdateUserID])
     VALUES
           (null, 'ISO Code',GETDATE(),1)

INSERT INTO [Keeley].[dbo].[IdentifierType]
           ([FMIdentType],[Name],[StartDt],[UpdateUserID])
     VALUES
           (null, 'Fund Manager Organisation ID',GETDATE(),1)

INSERT INTO [Keeley].[dbo].[IdentifierType]
           ([FMIdentType],[Name],[StartDt],[UpdateUserID])
     VALUES
           ('BB_COMPANY', 'Bloomberg Company Code',GETDATE(),1)

INSERT INTO [Keeley].[dbo].[IdentifierType]
           ([FMIdentType],[Name],[StartDt],[UpdateUserID])
     VALUES
           (null, 'Fund Manager Instrument Class',GETDATE(),1)
           
INSERT INTO [Keeley].[dbo].[IdentifierType]
           ([FMIdentType],[Name],[StartDt],[UpdateUserID])
     VALUES
           (null, 'Fund Manager Instrument Id',GETDATE(),1)

INSERT INTO [Keeley].[dbo].[IdentifierType]
           ([FMIdentType],[Name],[StartDt],[UpdateUserID])
     VALUES
           (null, 'Fund Manager Security Id',GETDATE(),1)

INSERT INTO [Keeley].[dbo].[IdentifierType]
           ([FMIdentType],[Name],[StartDt],[UpdateUserID])
     VALUES      
           ('ISIN', 'Isin',GETDATE(),1)           

INSERT INTO [Keeley].[dbo].[IdentifierType]
           ([FMIdentType],[Name],[StartDt],[UpdateUserID])
     VALUES      
           ('SEDOL', 'Sedol',GETDATE(),1)           

INSERT INTO [Keeley].[dbo].[IdentifierType]
           ([FMIdentType],[Name],[StartDt],[UpdateUserID])
     VALUES      
           ('BB_TCM', 'BB Ticker Coupon Maturity',GETDATE(),1)  