USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FactsetPortfolio_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FactsetPortfolio_Delete]
GO

CREATE PROCEDURE DBO.[FactsetPortfolio_Delete]
		@FactSetPortfolioId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FactsetPortfolio_hst (
			FactSetPortfolioId, FundId, ReferenceDate, CurrencyId, InstrumentName, OriginalIdentifier, InstrumentMarketId, InstrumentClassId, FMContId, ReturnContribution, PriceReturnContribution, CurrencyReturnContribution, CarryReturnContribution, IsItd, StartDt, UpdateUserId, DataVersion, EndDt, LastActionUserID)
	SELECT	FactSetPortfolioId, FundId, ReferenceDate, CurrencyId, InstrumentName, OriginalIdentifier, InstrumentMarketId, InstrumentClassId, FMContId, ReturnContribution, PriceReturnContribution, CurrencyReturnContribution, CarryReturnContribution, IsItd, StartDt, UpdateUserId, DataVersion, @EndDt, @UpdateUserID
	FROM	FactsetPortfolio
	WHERE	FactSetPortfolioId = @FactSetPortfolioId

	DELETE	FactsetPortfolio
	WHERE	FactSetPortfolioId = @FactSetPortfolioId
	AND		DataVersion = @DataVersion
GO
