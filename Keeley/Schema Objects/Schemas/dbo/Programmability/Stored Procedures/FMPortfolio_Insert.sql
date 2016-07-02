USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FMPortfolio_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FMPortfolio_Insert]
GO

CREATE PROCEDURE DBO.[FMPortfolio_Insert]
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
		@StrategyFMCode varchar(50)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FMPortfolio
			(ReferenceDate, ISecID, BookId, Currency, MaturityDate, NetPosition, Price, FXRate, MarketValue, DeltaMarketValue, TotalAccrual, UpdateUserID, StrategyFMCode, StartDt)
	VALUES
			(@ReferenceDate, @ISecID, @BookId, @Currency, @MaturityDate, @NetPosition, @Price, @FXRate, @MarketValue, @DeltaMarketValue, @TotalAccrual, @UpdateUserID, @StrategyFMCode, @StartDt)

	SELECT	FMPortfolioID, StartDt, DataVersion
	FROM	FMPortfolio
	WHERE	FMPortfolioID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
