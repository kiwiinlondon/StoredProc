USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[LoanedPortfolio_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[LoanedPortfolio_Delete]
GO

CREATE PROCEDURE DBO.[LoanedPortfolio_Delete]
		@LoanedPortfolioId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO LoanedPortfolio_hst (
			LoanedPortfolioId, FundId, ReferenceDate, BorrowerId, InstrumentMarketId, Quantity, Price, MarketValue, Rate, GrossFee, PBFee, StartDt, UpdateUserId, DataVersion, EndDt, LastActionUserID)
	SELECT	LoanedPortfolioId, FundId, ReferenceDate, BorrowerId, InstrumentMarketId, Quantity, Price, MarketValue, Rate, GrossFee, PBFee, StartDt, UpdateUserId, DataVersion, @EndDt, @UpdateUserID
	FROM	LoanedPortfolio
	WHERE	LoanedPortfolioId = @LoanedPortfolioId

	DELETE	LoanedPortfolio
	WHERE	LoanedPortfolioId = @LoanedPortfolioId
	AND		DataVersion = @DataVersion
GO
