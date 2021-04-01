USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[LoanedPortfolio_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[LoanedPortfolio_Insert]
GO

CREATE PROCEDURE DBO.[LoanedPortfolio_Insert]
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
		@UpdateUserId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into LoanedPortfolio
			(FundId, ReferenceDate, BorrowerId, InstrumentMarketId, Quantity, Price, MarketValue, Rate, GrossFee, PBFee, UpdateUserId, StartDt)
	VALUES
			(@FundId, @ReferenceDate, @BorrowerId, @InstrumentMarketId, @Quantity, @Price, @MarketValue, @Rate, @GrossFee, @PBFee, @UpdateUserId, @StartDt)

	SELECT	LoanedPortfolioId, StartDt, DataVersion
	FROM	LoanedPortfolio
	WHERE	LoanedPortfolioId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
