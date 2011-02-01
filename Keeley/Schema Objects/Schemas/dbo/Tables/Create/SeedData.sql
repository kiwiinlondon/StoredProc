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
	
