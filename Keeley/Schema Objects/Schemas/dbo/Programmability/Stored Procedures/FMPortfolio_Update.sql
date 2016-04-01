USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FMPortfolio_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FMPortfolio_Update]
GO

CREATE PROCEDURE DBO.[FMPortfolio_Update]
		@FMPortfolioID int, 
		@ReferenceDate datetime, 
		@ISecID int, 
		@BookId int, 
		@Currency varchar(3), 
		@MaturityDate datetime, 
		@NetPosition numeric(27,8), 
		@Price numeric(27,8), 
		@FXRate numeric(27,8), 
		@MarketValue numeric(27,8), 
		@DeltaMarketValue numeric(27,8), 
		@TotalAccrual numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@StrategyFMCode varchar(10)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FMPortfolio_hst (
			FMPortfolioID, ReferenceDate, ISecID, BookId, Currency, MaturityDate, NetPosition, Price, FXRate, MarketValue, DeltaMarketValue, TotalAccrual, StartDt, UpdateUserID, DataVersion, StrategyFMCode, EndDt, LastActionUserID)
	SELECT	FMPortfolioID, ReferenceDate, ISecID, BookId, Currency, MaturityDate, NetPosition, Price, FXRate, MarketValue, DeltaMarketValue, TotalAccrual, StartDt, UpdateUserID, DataVersion, StrategyFMCode, @StartDt, @UpdateUserID
	FROM	FMPortfolio
	WHERE	FMPortfolioID = @FMPortfolioID

	UPDATE	FMPortfolio
	SET		ReferenceDate = @ReferenceDate, ISecID = @ISecID, BookId = @BookId, Currency = @Currency, MaturityDate = @MaturityDate, NetPosition = @NetPosition, Price = @Price, FXRate = @FXRate, MarketValue = @MarketValue, DeltaMarketValue = @DeltaMarketValue, TotalAccrual = @TotalAccrual, UpdateUserID = @UpdateUserID, StrategyFMCode = @StrategyFMCode,  StartDt = @StartDt
	WHERE	FMPortfolioID = @FMPortfolioID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FMPortfolio
	WHERE	FMPortfolioID = @FMPortfolioID
	AND		@@ROWCOUNT > 0

GO
