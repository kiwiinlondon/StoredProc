USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[LegalEntity_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[LegalEntity_Delete]
GO

CREATE PROCEDURE DBO.[LegalEntity_Delete]
		@LegalEntityID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO LegalEntity_hst (
			LegalEntityID, FMOrgId, Name, LongName, CountryID, StartDt, UpdateUserID, DataVersion, BBCompany, CountryOfIncorporationId, CountryOfDomicileId, ParentLegalEntityId, PulseIdentifier, CompanySizeId, MarketCapUSD, UltimateParentName, UltimateParentLEI, LEI, EndDt, LastActionUserID)
	SELECT	LegalEntityID, FMOrgId, Name, LongName, CountryID, StartDt, UpdateUserID, DataVersion, BBCompany, CountryOfIncorporationId, CountryOfDomicileId, ParentLegalEntityId, PulseIdentifier, CompanySizeId, MarketCapUSD, UltimateParentName, UltimateParentLEI, LEI, @EndDt, @UpdateUserID
	FROM	LegalEntity
	WHERE	LegalEntityID = @LegalEntityID

	DELETE	LegalEntity
	WHERE	LegalEntityID = @LegalEntityID
	AND		DataVersion = @DataVersion
GO
