USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FinancingTmp_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FinancingTmp_Delete]
GO

CREATE PROCEDURE DBO.[FinancingTmp_Delete]
		@ ,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FinancingTmp_hst (
			FinancingId, FundId, InstrumentMarketId, ReferenceDate, CurrencyId, CustodianId, NetPosition, Price, Notional, FinancingRate, BorrowRate, FinancingAccrual, BorrowAccrual, AllInAccrual, StartDt, UpdateUserID, DataVersion, OverborrowNotional, OverborrowUnits, OverborrowRate, OverborrowAccrual, MarginInterest, CashInterest, FinancingControlId, RehypothecationEarning, DayCount, DayBasis, CashInterestRate, CashBalance, MarginBalance, RealisedAllInAccrual, SourcedExternally, CashInterestCredit, MarginRequirement, SwapFinancingCashBalanceDebit, SwapFinancingCashBalanceCredit, CashInterestDebit, RehypothecationValue, RehypothecationUnits, MarginRequirementRate, MarginRequirementNotional, AccountTypeId, SwapFinancingCashInterestRateDebit, SwapFinancingCashInterestRateCredit, NonPrimaryRecordExists, EndDt, LastActionUserID)
	SELECT	FinancingId, FundId, InstrumentMarketId, ReferenceDate, CurrencyId, CustodianId, NetPosition, Price, Notional, FinancingRate, BorrowRate, FinancingAccrual, BorrowAccrual, AllInAccrual, StartDt, UpdateUserID, DataVersion, OverborrowNotional, OverborrowUnits, OverborrowRate, OverborrowAccrual, MarginInterest, CashInterest, FinancingControlId, RehypothecationEarning, DayCount, DayBasis, CashInterestRate, CashBalance, MarginBalance, RealisedAllInAccrual, SourcedExternally, CashInterestCredit, MarginRequirement, SwapFinancingCashBalanceDebit, SwapFinancingCashBalanceCredit, CashInterestDebit, RehypothecationValue, RehypothecationUnits, MarginRequirementRate, MarginRequirementNotional, AccountTypeId, SwapFinancingCashInterestRateDebit, SwapFinancingCashInterestRateCredit, NonPrimaryRecordExists, @EndDt, @UpdateUserID
	FROM	FinancingTmp
	WHERE	 = @

	DELETE	FinancingTmp
	WHERE	 = @
	AND		DataVersion = @DataVersion
GO
