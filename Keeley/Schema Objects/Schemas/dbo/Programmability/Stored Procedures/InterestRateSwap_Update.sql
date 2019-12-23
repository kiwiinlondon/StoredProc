USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InterestRateSwap_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InterestRateSwap_Update]
GO

CREATE PROCEDURE DBO.[InterestRateSwap_Update]
		@InstrumentId int, 
		@StartDate datetime, 
		@MaturityDate datetime, 
		@NPVCurrencyId int, 
		@PayCurrencyId int, 
		@PaySpread numeric(27,8), 
		@PayNotional numeric(27,8), 
		@PayIsFloating bit, 
		@PayRollConventionId int, 
		@PayDayCountConventionId int, 
		@PayCouponFrequency int, 
		@PayFixedRate numeric(27,8), 
		@PayFloatingIndexInstrumentMarketId int, 
		@ReceiveCurrencyId int, 
		@ReceiveSpread numeric(27,8), 
		@ReceiveNotional numeric(27,8), 
		@ReceiveIsFloating bit, 
		@ReceiveRollConventionId int, 
		@ReceiveDayCountConventionId int, 
		@ReceiveCouponFrequency int, 
		@ReceiveFixedRate numeric(27,8), 
		@ReceiveFloatingIndexInstrumentMarketId int, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@PayFirstPaymentDate datetime, 
		@ReceiveFirstPaymentDate datetime
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO InterestRateSwap_hst (
			InstrumentId, StartDate, MaturityDate, NPVCurrencyId, PayCurrencyId, PaySpread, PayNotional, PayIsFloating, PayRollConventionId, PayDayCountConventionId, PayCouponFrequency, PayFixedRate, PayFloatingIndexInstrumentMarketId, ReceiveCurrencyId, ReceiveSpread, ReceiveNotional, ReceiveIsFloating, ReceiveRollConventionId, ReceiveDayCountConventionId, ReceiveCouponFrequency, ReceiveFixedRate, ReceiveFloatingIndexInstrumentMarketId, StartDt, UpdateUserID, DataVersion, PayFirstPaymentDate, ReceiveFirstPaymentDate, EndDt, LastActionUserID)
	SELECT	InstrumentId, StartDate, MaturityDate, NPVCurrencyId, PayCurrencyId, PaySpread, PayNotional, PayIsFloating, PayRollConventionId, PayDayCountConventionId, PayCouponFrequency, PayFixedRate, PayFloatingIndexInstrumentMarketId, ReceiveCurrencyId, ReceiveSpread, ReceiveNotional, ReceiveIsFloating, ReceiveRollConventionId, ReceiveDayCountConventionId, ReceiveCouponFrequency, ReceiveFixedRate, ReceiveFloatingIndexInstrumentMarketId, StartDt, UpdateUserID, DataVersion, PayFirstPaymentDate, ReceiveFirstPaymentDate, @StartDt, @UpdateUserID
	FROM	InterestRateSwap
	WHERE	InstrumentId = @InstrumentId

	UPDATE	InterestRateSwap
	SET		StartDate = @StartDate, MaturityDate = @MaturityDate, NPVCurrencyId = @NPVCurrencyId, PayCurrencyId = @PayCurrencyId, PaySpread = @PaySpread, PayNotional = @PayNotional, PayIsFloating = @PayIsFloating, PayRollConventionId = @PayRollConventionId, PayDayCountConventionId = @PayDayCountConventionId, PayCouponFrequency = @PayCouponFrequency, PayFixedRate = @PayFixedRate, PayFloatingIndexInstrumentMarketId = @PayFloatingIndexInstrumentMarketId, ReceiveCurrencyId = @ReceiveCurrencyId, ReceiveSpread = @ReceiveSpread, ReceiveNotional = @ReceiveNotional, ReceiveIsFloating = @ReceiveIsFloating, ReceiveRollConventionId = @ReceiveRollConventionId, ReceiveDayCountConventionId = @ReceiveDayCountConventionId, ReceiveCouponFrequency = @ReceiveCouponFrequency, ReceiveFixedRate = @ReceiveFixedRate, ReceiveFloatingIndexInstrumentMarketId = @ReceiveFloatingIndexInstrumentMarketId, UpdateUserID = @UpdateUserID, PayFirstPaymentDate = @PayFirstPaymentDate, ReceiveFirstPaymentDate = @ReceiveFirstPaymentDate,  StartDt = @StartDt
	WHERE	InstrumentId = @InstrumentId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	InterestRateSwap
	WHERE	InstrumentId = @InstrumentId
	AND		@@ROWCOUNT > 0

GO
