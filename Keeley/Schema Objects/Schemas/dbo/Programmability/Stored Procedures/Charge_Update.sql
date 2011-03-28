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
		@InternalAllocationID int, 
		@ChargeTypeId int, 
		@CurrencyId int, 
		@Quantity numeric(27,8), 
		@FXRate numeric(35,16), 
		@FXRateMultiply bit, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Charge_hst (
			ChargeId, InternalAllocationID, ChargeTypeId, CurrencyId, Quantity, FXRate, FXRateMultiply, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ChargeId, InternalAllocationID, ChargeTypeId, CurrencyId, Quantity, FXRate, FXRateMultiply, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	Charge
	WHERE	ChargeId = @ChargeId

	UPDATE	Charge
	SET		InternalAllocationID = @InternalAllocationID, ChargeTypeId = @ChargeTypeId, CurrencyId = @CurrencyId, Quantity = @Quantity, FXRate = @FXRate, FXRateMultiply = @FXRateMultiply, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ChargeId = @ChargeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Charge
	WHERE	ChargeId = @ChargeId
	AND		@@ROWCOUNT > 0

GO
