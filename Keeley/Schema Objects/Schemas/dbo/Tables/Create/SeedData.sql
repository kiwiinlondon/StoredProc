SET IDENTITY_INSERT ApplicationUser ON

INSERT INTO [Keeley].[dbo].[ApplicationUser]
	([UserID],[FMPersID],[Name],[Email],[WindowsLogin],[StartDt],[UpdateUserID])
     VALUES
           (1,null,'Geoff Poore','g.poore@odey.com','OAM\geoffp',GETDATE(),1)

SET IDENTITY_INSERT ApplicationUser OFF