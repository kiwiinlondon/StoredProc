USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InterestRateSwap_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InterestRateSwap_Insert]
GO

CREATE PROCEDURE DBO.[InterestRateSwap_Insert]
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
		@PayFirstPaymentDate datetime, 
		@ReceiveFirstPaymentDate datetime
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into InterestRateSwap
			(InstrumentId, StartDate, MaturityDate, NPVCurrencyId, PayCurrencyId, PaySpread, PayNotional, PayIsFloating, PayRollConventionId, PayDayCountConventionId, PayCouponFrequency, PayFixedRate, PayFloatingIndexInstrumentMarketId, ReceiveCurrencyId, ReceiveSpread, ReceiveNotional, ReceiveIsFloating, ReceiveRollConventionId, ReceiveDayCountConventionId, ReceiveCouponFrequency, ReceiveFixedRate, ReceiveFloatingIndexInstrumentMarketId, UpdateUserID, PayFirstPaymentDate, ReceiveFirstPaymentDate, StartDt)
	VALUES
			(@InstrumentId, @StartDate, @MaturityDate, @NPVCurrencyId, @PayCurrencyId, @PaySpread, @PayNotional, @PayIsFloating, @PayRollConventionId, @PayDayCountConventionId, @PayCouponFrequency, @PayFixedRate, @PayFloatingIndexInstrumentMarketId, @ReceiveCurrencyId, @ReceiveSpread, @ReceiveNotional, @ReceiveIsFloating, @ReceiveRollConventionId, @ReceiveDayCountConventionId, @ReceiveCouponFrequency, @ReceiveFixedRate, @ReceiveFloatingIndexInstrumentMarketId, @UpdateUserID, @PayFirstPaymentDate, @ReceiveFirstPaymentDate, @StartDt)

	SELECT	InstrumentId, StartDt, DataVersion
	FROM	InterestRateSwap
	WHERE	InstrumentId = @InstrumentId
	AND		@@ROWCOUNT > 0

GO
