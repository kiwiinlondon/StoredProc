USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InterestRateSwap_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InterestRateSwap_Delete]
GO

CREATE PROCEDURE DBO.[InterestRateSwap_Delete]
		@InstrumentId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO InterestRateSwap_hst (
			InstrumentId, StartDate, MaturityDate, NPVCurrencyId, PayCurrencyId, PaySpread, PayNotional, PayIsFloating, PayRollConventionId, PayDayCountConventionId, PayCouponFrequency, PayFixedRate, PayFloatingIndexInstrumentMarketId, ReceiveCurrencyId, ReceiveSpread, ReceiveNotional, ReceiveIsFloating, ReceiveRollConventionId, ReceiveDayCountConventionId, ReceiveCouponFrequency, ReceiveFixedRate, ReceiveFloatingIndexInstrumentMarketId, StartDt, UpdateUserID, DataVersion, PayFirstPaymentDate, ReceiveFirstPaymentDate, EndDt, LastActionUserID)
	SELECT	InstrumentId, StartDate, MaturityDate, NPVCurrencyId, PayCurrencyId, PaySpread, PayNotional, PayIsFloating, PayRollConventionId, PayDayCountConventionId, PayCouponFrequency, PayFixedRate, PayFloatingIndexInstrumentMarketId, ReceiveCurrencyId, ReceiveSpread, ReceiveNotional, ReceiveIsFloating, ReceiveRollConventionId, ReceiveDayCountConventionId, ReceiveCouponFrequency, ReceiveFixedRate, ReceiveFloatingIndexInstrumentMarketId, StartDt, UpdateUserID, DataVersion, PayFirstPaymentDate, ReceiveFirstPaymentDate, @EndDt, @UpdateUserID
	FROM	InterestRateSwap
	WHERE	InstrumentId = @InstrumentId

	DELETE	InterestRateSwap
	WHERE	InstrumentId = @InstrumentId
	AND		DataVersion = @DataVersion
GO
