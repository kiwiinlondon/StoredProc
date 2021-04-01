USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[LoanedPortfolioCollatoral_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[LoanedPortfolioCollatoral_Insert]
GO

CREATE PROCEDURE DBO.[LoanedPortfolioCollatoral_Insert]
		@FundId int, 
		@ReferenceDate datetime, 
		@BorrowerId int, 
		@InstrumentMarketId int, 
		@Quantity numeric(27,8), 
		@Price numeric(27,8), 
		@MarketValue numeric(27,8), 
		@UpdateUserId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into LoanedPortfolioCollatoral
			(FundId, ReferenceDate, BorrowerId, InstrumentMarketId, Quantity, Price, MarketValue, UpdateUserId, StartDt)
	VALUES
			(@FundId, @ReferenceDate, @BorrowerId, @InstrumentMarketId, @Quantity, @Price, @MarketValue, @UpdateUserId, @StartDt)

	SELECT	LoanedPortfolioCollatoralId, StartDt, DataVersion
	FROM	LoanedPortfolioCollatoral
	WHERE	LoanedPortfolioCollatoralId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
