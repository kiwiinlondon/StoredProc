﻿USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientTrade_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientTrade_Insert]
GO

CREATE PROCEDURE DBO.[ClientTrade_Insert]
		@SettlementDate datetime, 
		@TradeDate datetime, 
		@ClientTradeTypeId int, 
		@FundId int, 
		@TradeReference varchar(20), 
		@Quantity numeric(27,8), 
		@Price numeric(27,8), 
		@CurrencyId int, 
		@Discount numeric(27,8), 
		@NetConsideration numeric(27,8), 
		@Commission numeric(27,8), 
		@DilutionLevy numeric(27,8), 
		@ClientAccountId int, 
		@UpdateUserID int, 
		@HWMPrice numeric(27,8), 
		@CurrentQuantity numeric(27,8), 
		@EqFactor numeric(27,8), 
		@Balance numeric(27,8), 
		@TotalCost numeric(27,8), 
		@AdministratorCurrentQuantity numeric(27,8), 
		@Cost numeric(27,8), 
		@RelatedTradeId int, 
		@TransferPriceOverride numeric(27,8), 
		@BalanceEndOfDay numeric(27,8), 
		@NavDate datetime, 
		@NetConsiderationEuro numeric(27,8), 
		@IndexUnits numeric(27,8), 
		@EqFactorEuro numeric(27,8), 
		@NetConsiderationGBP numeric(27,8), 
		@EqFactorGBP numeric(27,8), 
		@NetConsiderationUSD numeric(27,8), 
		@EqFactorUSD numeric(27,8), 
		@CostEuro numeric(27,8), 
		@CostUSD numeric(27,8), 
		@CostGBP numeric(27,8), 
		@IsEstimate bit, 
		@CashSettlementDate datetime
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ClientTrade
			(SettlementDate, TradeDate, ClientTradeTypeId, FundId, TradeReference, Quantity, Price, CurrencyId, Discount, NetConsideration, Commission, DilutionLevy, ClientAccountId, UpdateUserID, HWMPrice, CurrentQuantity, EqFactor, Balance, TotalCost, AdministratorCurrentQuantity, Cost, RelatedTradeId, TransferPriceOverride, BalanceEndOfDay, NavDate, NetConsiderationEuro, IndexUnits, EqFactorEuro, NetConsiderationGBP, EqFactorGBP, NetConsiderationUSD, EqFactorUSD, CostEuro, CostUSD, CostGBP, IsEstimate, CashSettlementDate, StartDt)
	VALUES
			(@SettlementDate, @TradeDate, @ClientTradeTypeId, @FundId, @TradeReference, @Quantity, @Price, @CurrencyId, @Discount, @NetConsideration, @Commission, @DilutionLevy, @ClientAccountId, @UpdateUserID, @HWMPrice, @CurrentQuantity, @EqFactor, @Balance, @TotalCost, @AdministratorCurrentQuantity, @Cost, @RelatedTradeId, @TransferPriceOverride, @BalanceEndOfDay, @NavDate, @NetConsiderationEuro, @IndexUnits, @EqFactorEuro, @NetConsiderationGBP, @EqFactorGBP, @NetConsiderationUSD, @EqFactorUSD, @CostEuro, @CostUSD, @CostGBP, @IsEstimate, @CashSettlementDate, @StartDt)

	SELECT	ClientTradeId, StartDt, DataVersion
	FROM	ClientTrade
	WHERE	ClientTradeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
