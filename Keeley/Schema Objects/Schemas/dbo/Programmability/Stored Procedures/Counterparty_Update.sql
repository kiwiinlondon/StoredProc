USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Counterparty_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Counterparty_Update]
GO

CREATE PROCEDURE DBO.[Counterparty_Update]
		@LegalEntityID int, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@IsElectronic bit, 
		@UbsCsaName varchar(50), 
		@UbsCsaRateOverride numeric(27,8), 
		@CsaIdentifier varchar(50)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Counterparty_hst (
			LegalEntityID, StartDt, UpdateUserID, DataVersion, IsElectronic, UbsCsaName, UbsCsaRateOverride, CsaIdentifier, EndDt, LastActionUserID)
	SELECT	LegalEntityID, StartDt, UpdateUserID, DataVersion, IsElectronic, UbsCsaName, UbsCsaRateOverride, CsaIdentifier, @StartDt, @UpdateUserID
	FROM	Counterparty
	WHERE	LegalEntityID = @LegalEntityID

	UPDATE	Counterparty
	SET		UpdateUserID = @UpdateUserID, IsElectronic = @IsElectronic, UbsCsaName = @UbsCsaName, UbsCsaRateOverride = @UbsCsaRateOverride, CsaIdentifier = @CsaIdentifier,  StartDt = @StartDt
	WHERE	LegalEntityID = @LegalEntityID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Counterparty
	WHERE	LegalEntityID = @LegalEntityID
	AND		@@ROWCOUNT > 0

GO
