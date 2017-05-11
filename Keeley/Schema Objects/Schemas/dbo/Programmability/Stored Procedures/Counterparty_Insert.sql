USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Counterparty_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Counterparty_Insert]
GO

CREATE PROCEDURE DBO.[Counterparty_Insert]
		@LegalEntityID int, 
		@UpdateUserID int, 
		@IsElectronic bit, 
		@UbsCsaName varchar(50), 
		@UbsCsaRateOverride numeric(27,8), 
		@CsaIdentifier varchar(50), 
		@CsaRateOverrideSwaps numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Counterparty
			(LegalEntityID, UpdateUserID, IsElectronic, UbsCsaName, UbsCsaRateOverride, CsaIdentifier, CsaRateOverrideSwaps, StartDt)
	VALUES
			(@LegalEntityID, @UpdateUserID, @IsElectronic, @UbsCsaName, @UbsCsaRateOverride, @CsaIdentifier, @CsaRateOverrideSwaps, @StartDt)

	SELECT	LegalEntityID, StartDt, DataVersion
	FROM	Counterparty
	WHERE	LegalEntityID = @LegalEntityID
	AND		@@ROWCOUNT > 0

GO
