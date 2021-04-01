USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[LoanedPortfolioCollatoral_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[LoanedPortfolioCollatoral_Update]
GO

CREATE PROCEDURE DBO.[LoanedPortfolioCollatoral_Update]
		@LoanedPortfolioCollatoralId int, 
		@FundId int, 
		@ReferenceDate datetime, 
		@BorrowerId int, 
		@InstrumentMarketId int, 
		@Quantity numeric(27,8), 
		@Price numeric(27,8), 
		@MarketValue numeric(27,8), 
		@UpdateUserId int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO LoanedPortfolioCollatoral_hst (
			LoanedPortfolioCollatoralId, FundId, ReferenceDate, BorrowerId, InstrumentMarketId, Quantity, Price, MarketValue, StartDt, UpdateUserId, DataVersion, EndDt, LastActionUserID)
	SELECT	LoanedPortfolioCollatoralId, FundId, ReferenceDate, BorrowerId, InstrumentMarketId, Quantity, Price, MarketValue, StartDt, UpdateUserId, DataVersion, @StartDt, @UpdateUserID
	FROM	LoanedPortfolioCollatoral
	WHERE	LoanedPortfolioCollatoralId = @LoanedPortfolioCollatoralId

	UPDATE	LoanedPortfolioCollatoral
	SET		FundId = @FundId, ReferenceDate = @ReferenceDate, BorrowerId = @BorrowerId, InstrumentMarketId = @InstrumentMarketId, Quantity = @Quantity, Price = @Price, MarketValue = @MarketValue, UpdateUserId = @UpdateUserId,  StartDt = @StartDt
	WHERE	LoanedPortfolioCollatoralId = @LoanedPortfolioCollatoralId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	LoanedPortfolioCollatoral
	WHERE	LoanedPortfolioCollatoralId = @LoanedPortfolioCollatoralId
	AND		@@ROWCOUNT > 0

GO
