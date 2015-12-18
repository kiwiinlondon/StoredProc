USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Issuer_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Issuer_Update]
GO

CREATE PROCEDURE DBO.[Issuer_Update]
		@LegalEntityID int, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@FactsetId varchar(150), 
		@GicsLevel3IndustryID int, 
		@IssuerTypeId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Issuer_hst (
			LegalEntityID, StartDt, UpdateUserID, DataVersion, FactsetId, GicsLevel3IndustryID, IssuerTypeId, EndDt, LastActionUserID)
	SELECT	LegalEntityID, StartDt, UpdateUserID, DataVersion, FactsetId, GicsLevel3IndustryID, IssuerTypeId, @StartDt, @UpdateUserID
	FROM	Issuer
	WHERE	LegalEntityID = @LegalEntityID

	UPDATE	Issuer
	SET		UpdateUserID = @UpdateUserID, FactsetId = @FactsetId, GicsLevel3IndustryID = @GicsLevel3IndustryID, IssuerTypeId = @IssuerTypeId,  StartDt = @StartDt
	WHERE	LegalEntityID = @LegalEntityID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Issuer
	WHERE	LegalEntityID = @LegalEntityID
	AND		@@ROWCOUNT > 0

GO
