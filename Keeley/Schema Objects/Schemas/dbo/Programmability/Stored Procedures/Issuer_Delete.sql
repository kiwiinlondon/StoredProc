USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Issuer_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Issuer_Delete]

GO
CREATE PROCEDURE DBO.[Issuer_Delete]
		@LegalEntityID timestamp,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Issuer_hst (
			LegalEntityID, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	LegalEntityID, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	Issuer
	WHERE	LegalEntityID = LegalEntityID

	DELETE	Issuer
	WHERE	LegalEntityID = @LegalEntityID
	AND		DataVersion = @DataVersion
GO
