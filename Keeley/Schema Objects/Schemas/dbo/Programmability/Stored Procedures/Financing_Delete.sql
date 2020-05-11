USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Financing_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Financing_Delete]
GO

CREATE PROCEDURE DBO.[Financing_Delete]
		@FinancingId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Financing_hst (
			FinancingId, FundId, InstrumentMarketId, ReferenceDate, CurrencyId, CustodianId, NetPosition, Price, Notional, FinancingRate, BorrowRate, FinancingAccrual, BorrowAccrual, AllInAccrual, StartDt, UpdateUserID, DataVersion, OverborrowNotional, OverborrowUnits, OverborrowRate, OverborrowAccrual, MarginInterest, CashInterest, IsDummy, FinancingControlId, RehypothecationEarning, DayCount, DayBasis, CashInterestRate, CashBalance, MarginBalance, RealisedAllInAccrual, SourcedExternally, CashInterestCredit, MarginRequirement, SwapFinancingCashBalanceDebit, SwapFinancingCashBalanceCredit, CashInterestDebit, RehypothecationValue, RehypothecationUnits, MarginRequirementRate, MarginRequirementNotional, AccountTypeId, SwapFinancingCashInterestRateDebit, SwapFinancingCashInterestRateCredit, NonPrimaryRecordExists, EndDt, LastActionUserID)
	SELECT	FinancingId, FundId, InstrumentMarketId, ReferenceDate, CurrencyId, CustodianId, NetPosition, Price, Notional, FinancingRate, BorrowRate, FinancingAccrual, BorrowAccrual, AllInAccrual, StartDt, UpdateUserID, DataVersion, OverborrowNotional, OverborrowUnits, OverborrowRate, OverborrowAccrual, MarginInterest, CashInterest, IsDummy, FinancingControlId, RehypothecationEarning, DayCount, DayBasis, CashInterestRate, CashBalance, MarginBalance, RealisedAllInAccrual, SourcedExternally, CashInterestCredit, MarginRequirement, SwapFinancingCashBalanceDebit, SwapFinancingCashBalanceCredit, CashInterestDebit, RehypothecationValue, RehypothecationUnits, MarginRequirementRate, MarginRequirementNotional, AccountTypeId, SwapFinancingCashInterestRateDebit, SwapFinancingCashInterestRateCredit, NonPrimaryRecordExists, @EndDt, @UpdateUserID
	FROM	Financing
	WHERE	FinancingId = @FinancingId

	DELETE	Financing
	WHERE	FinancingId = @FinancingId
	AND		DataVersion = @DataVersion
GO
