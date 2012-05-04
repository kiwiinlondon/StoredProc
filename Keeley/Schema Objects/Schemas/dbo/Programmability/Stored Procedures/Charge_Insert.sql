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
		@EventID int, 
		@ReferenceDate datetime, 
		@ChargeTypeId int, 
		@CurrencyId int, 
		@Quantity numeric(27,8), 
		@FXRate numeric(35,16), 
		@UpdateUserID int, 
		@LegalEntityChargeScheduleId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Charge
			(EventID, ReferenceDate, ChargeTypeId, CurrencyId, Quantity, FXRate, UpdateUserID, LegalEntityChargeScheduleId, StartDt)
	VALUES
			(@EventID, @ReferenceDate, @ChargeTypeId, @CurrencyId, @Quantity, @FXRate, @UpdateUserID, @LegalEntityChargeScheduleId, @StartDt)

	SELECT	ChargeId, StartDt, DataVersion
	FROM	Charge
	WHERE	ChargeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
