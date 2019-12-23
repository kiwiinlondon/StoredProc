USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Charge_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Charge_Update]
GO

CREATE PROCEDURE DBO.[Charge_Update]
		@ChargeId int, 
		@EventID int, 
		@ReferenceDate datetime, 
		@ChargeTypeId int, 
		@CurrencyId int, 
		@Quantity numeric(27,8), 
		@FXRate numeric(35,16), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@LegalEntityChargeScheduleId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Charge_hst (
			ChargeId, EventID, ReferenceDate, ChargeTypeId, CurrencyId, Quantity, FXRate, StartDt, UpdateUserID, DataVersion, LegalEntityChargeScheduleId, EndDt, LastActionUserID)
	SELECT	ChargeId, EventID, ReferenceDate, ChargeTypeId, CurrencyId, Quantity, FXRate, StartDt, UpdateUserID, DataVersion, LegalEntityChargeScheduleId, @StartDt, @UpdateUserID
	FROM	Charge
	WHERE	ChargeId = @ChargeId

	UPDATE	Charge
	SET		EventID = @EventID, ReferenceDate = @ReferenceDate, ChargeTypeId = @ChargeTypeId, CurrencyId = @CurrencyId, Quantity = @Quantity, FXRate = @FXRate, UpdateUserID = @UpdateUserID, LegalEntityChargeScheduleId = @LegalEntityChargeScheduleId,  StartDt = @StartDt
	WHERE	ChargeId = @ChargeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Charge
	WHERE	ChargeId = @ChargeId
	AND		@@ROWCOUNT > 0

GO
