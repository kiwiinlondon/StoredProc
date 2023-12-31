﻿USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[LegalEntity_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[LegalEntity_Update]
GO

CREATE PROCEDURE DBO.[LegalEntity_Update]
		@LegalEntityID int, 
		@FMOrgId int, 
		@Name varchar(70), 
		@LongName varchar(100), 
		@CountryID int, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@BBCompany int, 
		@CountryOfIncorporationId int, 
		@CountryOfDomicileId int, 
		@ParentLegalEntityId int, 
		@PulseIdentifier varchar(100), 
		@CompanySizeId int, 
		@MarketCapUSD numeric(15,0), 
		@UltimateParentName varchar(100), 
		@UltimateParentLEI varchar(100), 
		@LEI varchar(100)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO LegalEntity_hst (
			LegalEntityID, FMOrgId, Name, LongName, CountryID, StartDt, UpdateUserID, DataVersion, BBCompany, CountryOfIncorporationId, CountryOfDomicileId, ParentLegalEntityId, PulseIdentifier, CompanySizeId, MarketCapUSD, UltimateParentName, UltimateParentLEI, LEI, EndDt, LastActionUserID)
	SELECT	LegalEntityID, FMOrgId, Name, LongName, CountryID, StartDt, UpdateUserID, DataVersion, BBCompany, CountryOfIncorporationId, CountryOfDomicileId, ParentLegalEntityId, PulseIdentifier, CompanySizeId, MarketCapUSD, UltimateParentName, UltimateParentLEI, LEI, @StartDt, @UpdateUserID
	FROM	LegalEntity
	WHERE	LegalEntityID = @LegalEntityID

	UPDATE	LegalEntity
	SET		FMOrgId = @FMOrgId, Name = @Name, LongName = @LongName, CountryID = @CountryID, UpdateUserID = @UpdateUserID, BBCompany = @BBCompany, CountryOfIncorporationId = @CountryOfIncorporationId, CountryOfDomicileId = @CountryOfDomicileId, ParentLegalEntityId = @ParentLegalEntityId, PulseIdentifier = @PulseIdentifier, CompanySizeId = @CompanySizeId, MarketCapUSD = @MarketCapUSD, UltimateParentName = @UltimateParentName, UltimateParentLEI = @UltimateParentLEI, LEI = @LEI,  StartDt = @StartDt
	WHERE	LegalEntityID = @LegalEntityID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	LegalEntity
	WHERE	LegalEntityID = @LegalEntityID
	AND		@@ROWCOUNT > 0

GO
