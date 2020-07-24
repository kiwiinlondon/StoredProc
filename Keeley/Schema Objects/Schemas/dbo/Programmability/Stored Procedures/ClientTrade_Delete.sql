USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientTrade_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientTrade_Delete]
GO

CREATE PROCEDURE DBO.[ClientTrade_Delete]
		@ClientTradeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ClientTrade_hst (
			ClientTradeId, SettlementDate, TradeDate, ClientTradeTypeId, FundId, TradeReference, Quantity, Price, CurrencyId, Discount, NetConsideration, Commission, DilutionLevy, ClientAccountId, StartDt, UpdateUserID, DataVersion, HWMPrice, CurrentQuantity, EqFactor, Balance, TotalCost, AdministratorCurrentQuantity, Cost, RelatedTradeId, TransferPriceOverride, BalanceEndOfDay, NavDate, NetConsiderationEuro, IndexUnits, EqFactorEuro, NetConsiderationGBP, EqFactorGBP, NetConsiderationUSD, EqFactorUSD, CostEuro, CostUSD, CostGBP, IsEstimate, CashSettlementDate, EndDt, LastActionUserID)
	SELECT	ClientTradeId, SettlementDate, TradeDate, ClientTradeTypeId, FundId, TradeReference, Quantity, Price, CurrencyId, Discount, NetConsideration, Commission, DilutionLevy, ClientAccountId, StartDt, UpdateUserID, DataVersion, HWMPrice, CurrentQuantity, EqFactor, Balance, TotalCost, AdministratorCurrentQuantity, Cost, RelatedTradeId, TransferPriceOverride, BalanceEndOfDay, NavDate, NetConsiderationEuro, IndexUnits, EqFactorEuro, NetConsiderationGBP, EqFactorGBP, NetConsiderationUSD, EqFactorUSD, CostEuro, CostUSD, CostGBP, IsEstimate, CashSettlementDate, @EndDt, @UpdateUserID
	FROM	ClientTrade
	WHERE	ClientTradeId = @ClientTradeId

	DELETE	ClientTrade
	WHERE	ClientTradeId = @ClientTradeId
	AND		DataVersion = @DataVersion
GO
