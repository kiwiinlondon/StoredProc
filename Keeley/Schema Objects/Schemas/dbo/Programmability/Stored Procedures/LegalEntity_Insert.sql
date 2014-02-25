USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[LegalEntity_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[LegalEntity_Insert]
GO

CREATE PROCEDURE DBO.[LegalEntity_Insert]
		@FMOrgId int, 
		@Name varchar(70), 
		@LongName varchar(100), 
		@CountryID int, 
		@UpdateUserID int, 
		@BBCompany int, 
		@CountryOfIncorporationId int, 
		@CountryOfDomicileId int, 
		@ParentLegalEntityId int=null, 
		@PulseIdentifier varchar(100) = NUll
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into LegalEntity
			(FMOrgId, Name, LongName, CountryID, UpdateUserID, BBCompany, CountryOfIncorporationId, CountryOfDomicileId, ParentLegalEntityId, PulseIdentifier, StartDt)
	VALUES
			(@FMOrgId, @Name, @LongName, @CountryID, @UpdateUserID, @BBCompany, @CountryOfIncorporationId, @CountryOfDomicileId, @ParentLegalEntityId, @PulseIdentifier, @StartDt)

	SELECT	LegalEntityID, StartDt, DataVersion
	FROM	LegalEntity
	WHERE	LegalEntityID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
