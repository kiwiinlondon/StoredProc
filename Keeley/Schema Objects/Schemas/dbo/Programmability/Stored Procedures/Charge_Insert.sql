USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Charge_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Charge_Insert]
GO

CREATE PROCEDURE DBO.[Charge_Insert]
		@InternalAllocationID int, 
		@ChargeTypeId int, 
		@CurrencyId int, 
		@Quantity numeric(27,8), 
		@FXRate numeric(35,16), 
		@FXRateMultiply bit, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Charge
			(InternalAllocationID, ChargeTypeId, CurrencyId, Quantity, FXRate, FXRateMultiply, UpdateUserID, StartDt)
	VALUES
			(@InternalAllocationID, @ChargeTypeId, @CurrencyId, @Quantity, @FXRate, @FXRateMultiply, @UpdateUserID, @StartDt)

	SELECT	ChargeId, StartDt, DataVersion
	FROM	Charge
	WHERE	ChargeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
