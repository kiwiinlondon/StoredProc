USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientTrade_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientTrade_Update]
GO

CREATE PROCEDURE DBO.[ClientTrade_Update]
		@ClientTradeId int, 
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
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ClientTrade_hst (
			ClientTradeId, SettlementDate, TradeDate, ClientTradeTypeId, FundId, TradeReference, Quantity, Price, CurrencyId, Discount, NetConsideration, Commission, DilutionLevy, ClientAccountId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ClientTradeId, SettlementDate, TradeDate, ClientTradeTypeId, FundId, TradeReference, Quantity, Price, CurrencyId, Discount, NetConsideration, Commission, DilutionLevy, ClientAccountId, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ClientTrade
	WHERE	ClientTradeId = @ClientTradeId

	UPDATE	ClientTrade
	SET		SettlementDate = @SettlementDate, TradeDate = @TradeDate, ClientTradeTypeId = @ClientTradeTypeId, FundId = @FundId, TradeReference = @TradeReference, Quantity = @Quantity, Price = @Price, CurrencyId = @CurrencyId, Discount = @Discount, NetConsideration = @NetConsideration, Commission = @Commission, DilutionLevy = @DilutionLevy, ClientAccountId = @ClientAccountId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ClientTradeId = @ClientTradeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ClientTrade
	WHERE	ClientTradeId = @ClientTradeId
	AND		@@ROWCOUNT > 0

GO
