USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[LoanedPortfolioCollatoral_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[LoanedPortfolioCollatoral_Delete]
GO

CREATE PROCEDURE DBO.[LoanedPortfolioCollatoral_Delete]
		@LoanedPortfolioCollatoralId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO LoanedPortfolioCollatoral_hst (
			LoanedPortfolioCollatoralId, FundId, ReferenceDate, BorrowerId, InstrumentMarketId, Quantity, Price, MarketValue, StartDt, UpdateUserId, DataVersion, EndDt, LastActionUserID)
	SELECT	LoanedPortfolioCollatoralId, FundId, ReferenceDate, BorrowerId, InstrumentMarketId, Quantity, Price, MarketValue, StartDt, UpdateUserId, DataVersion, @EndDt, @UpdateUserID
	FROM	LoanedPortfolioCollatoral
	WHERE	LoanedPortfolioCollatoralId = @LoanedPortfolioCollatoralId

	DELETE	LoanedPortfolioCollatoral
	WHERE	LoanedPortfolioCollatoralId = @LoanedPortfolioCollatoralId
	AND		DataVersion = @DataVersion
GO
