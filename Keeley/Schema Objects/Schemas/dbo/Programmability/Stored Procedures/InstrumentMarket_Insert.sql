USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InstrumentMarket_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InstrumentMarket_Insert]
GO

CREATE PROCEDURE DBO.[InstrumentMarket_Insert]
		@InstrumentID int, 
		@MarketID int, 
		@BenefitCurrencyID int, 
		@FMSecId int, 
		@PriceDivisor numeric(33,18), 
		@BloombergTicker varchar(150), 
		@Sedol varchar(150), 
		@IsPrimary bit, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into InstrumentMarket
			(InstrumentID, MarketID, BenefitCurrencyID, FMSecId, PriceDivisor, BloombergTicker, Sedol, IsPrimary, UpdateUserID, StartDt)
	VALUES
			(@InstrumentID, @MarketID, @BenefitCurrencyID, @FMSecId, @PriceDivisor, @BloombergTicker, @Sedol, @IsPrimary, @UpdateUserID, @StartDt)

	SELECT	InstrumentMarketID, StartDt, DataVersion
	FROM	InstrumentMarket
	WHERE	InstrumentMarketID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
