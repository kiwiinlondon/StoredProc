USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[LoanedPortfolio_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[LoanedPortfolio_Update]
GO

CREATE PROCEDURE DBO.[LoanedPortfolio_Update]
		@LoanedPortfolioId int, 
		@FundId int, 
		@ReferenceDate datetime, 
		@BorrowerId int, 
		@InstrumentMarketId int, 
		@Quantity numeric(27,8), 
		@Price numeric(27,8), 
		@MarketValue numeric(27,8), 
		@Rate numeric(27,8), 
		@GrossFee numeric(27,8), 
		@PBFee numeric(27,8), 
		@UpdateUserId int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO LoanedPortfolio_hst (
			LoanedPortfolioId, FundId, ReferenceDate, BorrowerId, InstrumentMarketId, Quantity, Price, MarketValue, Rate, GrossFee, PBFee, StartDt, UpdateUserId, DataVersion, EndDt, LastActionUserID)
	SELECT	LoanedPortfolioId, FundId, ReferenceDate, BorrowerId, InstrumentMarketId, Quantity, Price, MarketValue, Rate, GrossFee, PBFee, StartDt, UpdateUserId, DataVersion, @StartDt, @UpdateUserID
	FROM	LoanedPortfolio
	WHERE	LoanedPortfolioId = @LoanedPortfolioId

	UPDATE	LoanedPortfolio
	SET		FundId = @FundId, ReferenceDate = @ReferenceDate, BorrowerId = @BorrowerId, InstrumentMarketId = @InstrumentMarketId, Quantity = @Quantity, Price = @Price, MarketValue = @MarketValue, Rate = @Rate, GrossFee = @GrossFee, PBFee = @PBFee, UpdateUserId = @UpdateUserId,  StartDt = @StartDt
	WHERE	LoanedPortfolioId = @LoanedPortfolioId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	LoanedPortfolio
	WHERE	LoanedPortfolioId = @LoanedPortfolioId
	AND		@@ROWCOUNT > 0

GO
