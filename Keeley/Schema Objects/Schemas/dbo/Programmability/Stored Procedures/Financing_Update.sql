﻿USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Financing_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Financing_Update]
GO

CREATE PROCEDURE DBO.[Financing_Update]
		@FinancingId int, 
		@FundId int, 
		@InstrumentMarketId int, 
		@ReferenceDate datetime, 
		@CurrencyId int, 
		@CustodianId int, 
		@NetPosition numeric(27,8), 
		@Price numeric(27,8), 
		@Notional numeric(27,8), 
		@FinancingRate numeric(27,8), 
		@BorrowRate numeric(27,8), 
		@FinancingAccrual numeric(27,8), 
		@BorrowAccrual numeric(27,8), 
		@AllInAccrual numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@OverborrowNotional numeric(27,8), 
		@OverborrowUnits numeric(27,8), 
		@OverborrowRate numeric(27,8), 
		@OverborrowAccrual numeric(27,8), 
		@MarginInterest numeric(27,8), 
		@CashInterest numeric(27,8), 
		@RehypothecationEarning numeric(27,8), 
		@CashInterestRate numeric(27,8), 
		@CashBalance numeric(27,8), 
		@MarginBalance numeric(27,8), 
		@CashInterestCredit numeric(27,8), 
		@MarginRequirement numeric(27,8), 
		@SwapFinancingCashBalanceDebit numeric(27,8), 
		@SwapFinancingCashBalanceCredit numeric(27,8), 
		@CashInterestDebit numeric(27,8), 
		@RehypothecationValue numeric(27,8), 
		@RehypothecationUnits numeric(27,8), 
		@MarginRequirementRate numeric(27,8), 
		@MarginRequirementNotional numeric(27,8), 
		@SwapFinancingCashInterestRateDebit numeric(27,8), 
		@SwapFinancingCashInterestRateCredit numeric(27,8), 
		@IsDummy bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Financing_hst (
			FinancingId, FundId, InstrumentMarketId, ReferenceDate, CurrencyId, CustodianId, NetPosition, Price, Notional, FinancingRate, BorrowRate, FinancingAccrual, BorrowAccrual, AllInAccrual, StartDt, UpdateUserID, DataVersion, OverborrowNotional, OverborrowUnits, OverborrowRate, OverborrowAccrual, MarginInterest, CashInterest, RehypothecationEarning, CashInterestRate, CashBalance, MarginBalance, CashInterestCredit, MarginRequirement, SwapFinancingCashBalanceDebit, SwapFinancingCashBalanceCredit, CashInterestDebit, RehypothecationValue, RehypothecationUnits, MarginRequirementRate, MarginRequirementNotional, SwapFinancingCashInterestRateDebit, SwapFinancingCashInterestRateCredit, IsDummy, EndDt, LastActionUserID)
	SELECT	FinancingId, FundId, InstrumentMarketId, ReferenceDate, CurrencyId, CustodianId, NetPosition, Price, Notional, FinancingRate, BorrowRate, FinancingAccrual, BorrowAccrual, AllInAccrual, StartDt, UpdateUserID, DataVersion, OverborrowNotional, OverborrowUnits, OverborrowRate, OverborrowAccrual, MarginInterest, CashInterest, RehypothecationEarning, CashInterestRate, CashBalance, MarginBalance, CashInterestCredit, MarginRequirement, SwapFinancingCashBalanceDebit, SwapFinancingCashBalanceCredit, CashInterestDebit, RehypothecationValue, RehypothecationUnits, MarginRequirementRate, MarginRequirementNotional, SwapFinancingCashInterestRateDebit, SwapFinancingCashInterestRateCredit, IsDummy, @StartDt, @UpdateUserID
	FROM	Financing
	WHERE	FinancingId = @FinancingId

	UPDATE	Financing
	SET		FundId = @FundId, InstrumentMarketId = @InstrumentMarketId, ReferenceDate = @ReferenceDate, CurrencyId = @CurrencyId, CustodianId = @CustodianId, NetPosition = @NetPosition, Price = @Price, Notional = @Notional, FinancingRate = @FinancingRate, BorrowRate = @BorrowRate, FinancingAccrual = @FinancingAccrual, BorrowAccrual = @BorrowAccrual, AllInAccrual = @AllInAccrual, UpdateUserID = @UpdateUserID, OverborrowNotional = @OverborrowNotional, OverborrowUnits = @OverborrowUnits, OverborrowRate = @OverborrowRate, OverborrowAccrual = @OverborrowAccrual, MarginInterest = @MarginInterest, CashInterest = @CashInterest, RehypothecationEarning = @RehypothecationEarning, CashInterestRate = @CashInterestRate, CashBalance = @CashBalance, MarginBalance = @MarginBalance, CashInterestCredit = @CashInterestCredit, MarginRequirement = @MarginRequirement, SwapFinancingCashBalanceDebit = @SwapFinancingCashBalanceDebit, SwapFinancingCashBalanceCredit = @SwapFinancingCashBalanceCredit, CashInterestDebit = @CashInterestDebit, RehypothecationValue = @RehypothecationValue, RehypothecationUnits = @RehypothecationUnits, MarginRequirementRate = @MarginRequirementRate, MarginRequirementNotional = @MarginRequirementNotional, SwapFinancingCashInterestRateDebit = @SwapFinancingCashInterestRateDebit, SwapFinancingCashInterestRateCredit = @SwapFinancingCashInterestRateCredit, IsDummy = @IsDummy,  StartDt = @StartDt
	WHERE	FinancingId = @FinancingId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Financing
	WHERE	FinancingId = @FinancingId
	AND		@@ROWCOUNT > 0

GO
