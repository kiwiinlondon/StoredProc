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
		@FactsetId varchar(150)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Issuer_hst (
			LegalEntityID, StartDt, UpdateUserID, DataVersion, FactsetId, EndDt, LastActionUserID)
	SELECT	LegalEntityID, StartDt, UpdateUserID, DataVersion, FactsetId, @StartDt, @UpdateUserID
	FROM	Issuer
	WHERE	LegalEntityID = @LegalEntityID

	UPDATE	Issuer
	SET		UpdateUserID = @UpdateUserID, FactsetId = @FactsetId,  StartDt = @StartDt
	WHERE	LegalEntityID = @LegalEntityID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Issuer
	WHERE	LegalEntityID = @LegalEntityID
	AND		@@ROWCOUNT > 0

GO
