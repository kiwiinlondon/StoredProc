USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FMPortfolio_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FMPortfolio_Delete]
GO

CREATE PROCEDURE DBO.[FMPortfolio_Delete]
		@FMPortfolioID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FMPortfolio_hst (
			FMPortfolioID, ReferenceDate, ISecID, BookId, Currency, MaturityDate, NetPosition, Price, FXRate, MarketValue, DeltaMarketValue, TotalAccrual, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FMPortfolioID, ReferenceDate, ISecID, BookId, Currency, MaturityDate, NetPosition, Price, FXRate, MarketValue, DeltaMarketValue, TotalAccrual, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	FMPortfolio
	WHERE	FMPortfolioID = @FMPortfolioID

	DELETE	FMPortfolio
	WHERE	FMPortfolioID = @FMPortfolioID
	AND		DataVersion = @DataVersion
GO
