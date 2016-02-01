USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Counterparty_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Counterparty_Delete]
GO

CREATE PROCEDURE DBO.[Counterparty_Delete]
		@LegalEntityID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Counterparty_hst (
			LegalEntityID, StartDt, UpdateUserID, DataVersion, IsElectronic, UbsCsaName, UbsCsaRateOverride, CsaIdentifier, EndDt, LastActionUserID)
	SELECT	LegalEntityID, StartDt, UpdateUserID, DataVersion, IsElectronic, UbsCsaName, UbsCsaRateOverride, CsaIdentifier, @EndDt, @UpdateUserID
	FROM	Counterparty
	WHERE	LegalEntityID = @LegalEntityID

	DELETE	Counterparty
	WHERE	LegalEntityID = @LegalEntityID
	AND		DataVersion = @DataVersion
GO
