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
           (null, 'BuySellReasonCode',GETDATE(),1)

INSERT INTO [Keeley].[dbo].[IdentifierType]
           ([FMIdentType],[Name],[StartDt],[UpdateUserID])
     VALUES
           (null, 'Fund Manager Person Id',GETDATE(),1)

INSERT INTO [Keeley].[dbo].[IdentifierType]
           ([FMIdentType],[Name],[StartDt],[UpdateUserID])
     VALUES
           (null, 'Fund Manager Security Id',GETDATE(),1)

INSERT INTO [Keeley].[dbo].[IdentifierType]
           ([FMIdentType],[Name],[StartDt],[UpdateUserID])
     VALUES
           (null, 'Fund Manager Account Id',GETDATE(),1)

INSERT INTO [Keeley].[dbo].[IdentifierType]
           ([FMIdentType],[Name],[StartDt],[UpdateUserID])
     VALUES
           (null, 'Fund Manager Original Cont Id',GETDATE(),1)

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

INSERT INTO [Keeley].[dbo].[IdentifierType]
           ([FMIdentType],[Name],[StartDt],[UpdateUserID])
     VALUES      
           (null, 'FM Charge Type',GETDATE(),1)  

INSERT INTO [Keeley].[dbo].[IdentifierType]
           ([FMIdentType],[Name],[StartDt],[UpdateUserID])
     VALUES      
           (null, 'Fund Manager Strategy',GETDATE(),1)  

INSERT INTO [Keeley].[dbo].[IdentifierType]
           ([FMIdentType],[Name],[StartDt],[UpdateUserID])
     VALUES      
           (null, 'Fund Manager Trad Type',GETDATE(),1)  

INSERT INTO [Keeley].[dbo].[IdentifierType]
           ([FMIdentType],[Name],[StartDt],[UpdateUserID])
     VALUES      
           (null, 'Fund Manager Cont Id',GETDATE(),1)  

INSERT INTO [Keeley].[dbo].[IdentifierType]
           ([FMIdentType],[Name],[StartDt],[UpdateUserID])
     VALUES      
           (null, 'Fund Manager XTFO Id',GETDATE(),1)   

INSERT INTO [Keeley].[dbo].[IdentifierType]
           ([FMIdentType],[Name],[StartDt],[UpdateUserID])
     VALUES
           (null, 'Fund Manager Original Contract Event Id',GETDATE(),1)


INSERT INTO [Keeley].[dbo].[IdentifierType]
           ([FMIdentType],[Name],[StartDt],[UpdateUserID])
     VALUES
           (null, 'Fund Manager Contract Event Id',GETDATE(),1)

INSERT INTO [Keeley].[dbo].[IdentifierType]
           ([FMIdentType],[Name],[StartDt],[UpdateUserID])
     VALUES
           (null, 'Fund Manager Contract Event Sub Type',GETDATE(),1)

INSERT INTO [Keeley].[dbo].[Region]
           ([Name],[IsoCode],[StartDt],[UpdateUserID])
     VALUES
           ('Unknown Region','UNK',GETDATE(),1)

INSERT INTO [Keeley].[dbo].[Country]
           ([Name],[IsoCode],[StartDt],[UpdateUserID],RegionID)
     VALUES
           ('Unknown Country','UNK',GETDATE(),1,1)

INSERT INTO [Keeley].[dbo].[LegalEntity]
           ([FMOrgId],[Name],[LongName],[CountryID],[StartDt],[UpdateUserID],[BBCompany])
     VALUES
           (null,'Unknown Legal Entity','Unknown Legal Entity',1,GETDATE(),1,null)

INSERT INTO [Keeley].[dbo].[Issuer]
           ([LegalEntityID],[StartDt],[UpdateUserID])
     VALUES
           (1,GETDATE(),1)

INSERT INTO [Keeley].[dbo].[Market]
           ([LegalEntityID],[StartDt],[UpdateUserID])
     VALUES
           (1,GETDATE(),1)

ALTER TABLE Instrument NOCHECK CONSTRAINT ALL

INSERT INTO [Keeley].[dbo].[Instrument]
           ([IssuerID],[InstrumentClassID],[IssueCurrencyID],[FMInstId],[Name],[LongName],[Isin],[StartDt],[UpdateUserID])
     VALUES
           (1,3,1,null,'Unknown Currency','Unknown Currency',null,GETDATE(),1)

INSERT INTO [Keeley].[dbo].[Currency]
           ([InstrumentID],[StartDt],[UpdateUserID])
     VALUES
           (1,GETDATE(),1)

INSERT INTO [Keeley].[dbo].[MatchedStatus]
           ([Code],[Name],[StartDt],[UpdateUserID])
     VALUES
           ('M','Matched',GETDATE(),1)
INSERT INTO [Keeley].[dbo].[MatchedStatus]
           ([Code],[Name],[StartDt],[UpdateUserID])
     VALUES
           ('N','Notified',GETDATE(),1)
INSERT INTO [Keeley].[dbo].[MatchedStatus]
           ([Code],[Name],[StartDt],[UpdateUserID])
     VALUES
           ('R','Rejected',GETDATE(),1)           
INSERT INTO [Keeley].[dbo].[MatchedStatus]
           ([Code],[Name],[StartDt],[UpdateUserID])
     VALUES
           ('CN','Broken',GETDATE(),1)           
           
INSERT INTO [Keeley].[dbo].[MatchedStatus]
           ([Code],[Name],[StartDt],[UpdateUserID])
     VALUES
           ('NA','Not Applicable',GETDATE(),1)  

	INSERT INTO [Keeley].[dbo].[PortfolioAggregationLevel]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('Trade Date',getdate(),1)

	INSERT INTO [Keeley].[dbo].[PortfolioAggregationLevel]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('Settlement Date',getdate(),1)           
           

ALTER TABLE Instrument WITH CHECK CHECK CONSTRAINT all

DBCC CHECKIDENT (InstrumentClass, reseed, 0)

