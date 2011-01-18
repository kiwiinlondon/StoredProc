USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InstrumentMarket_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InstrumentMarket_Update]
GO

CREATE PROCEDURE DBO.[InstrumentMarket_Update]
		@InstrumentMarketID int, 
		@InstrumentID int, 
		@MarketID int, 
		@BenefitCurrencyID int, 
		@FMSecId int, 
		@PriceDivisor numeric(33,18), 
		@BloombergTicker varchar(150), 
		@Sedol varchar(150), 
		@IsPrimary bit, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO InstrumentMarket_hst (
			InstrumentMarketID, InstrumentID, MarketID, BenefitCurrencyID, FMSecId, PriceDivisor, BloombergTicker, Sedol, IsPrimary, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	InstrumentMarketID, InstrumentID, MarketID, BenefitCurrencyID, FMSecId, PriceDivisor, BloombergTicker, Sedol, IsPrimary, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	InstrumentMarket
	WHERE	InstrumentMarketID = @InstrumentMarketID

	UPDATE	InstrumentMarket
	SET		InstrumentID = @InstrumentID, MarketID = @MarketID, BenefitCurrencyID = @BenefitCurrencyID, FMSecId = @FMSecId, PriceDivisor = @PriceDivisor, BloombergTicker = @BloombergTicker, Sedol = @Sedol, IsPrimary = @IsPrimary, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	InstrumentMarketID = @InstrumentMarketID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	InstrumentMarket
	WHERE	InstrumentMarketID = @InstrumentMarketID
	AND		@@ROWCOUNT > 0

GO
