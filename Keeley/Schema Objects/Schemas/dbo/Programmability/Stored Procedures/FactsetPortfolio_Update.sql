USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FactsetPortfolio_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FactsetPortfolio_Update]
GO

CREATE PROCEDURE DBO.[FactsetPortfolio_Update]
		@FactSetPortfolioId int, 
		@FundId int, 
		@ReferenceDate datetime, 
		@CurrencyId int, 
		@InstrumentName varchar(250), 
		@OriginalIdentifier varchar(100), 
		@InstrumentMarketId int, 
		@InstrumentClassId int, 
		@FMContId int, 
		@ReturnContribution numeric(27,8), 
		@PriceReturnContribution numeric(27,8), 
		@CurrencyReturnContribution numeric(27,8), 
		@CarryReturnContribution numeric(27,8), 
		@IsItd bit, 
		@UpdateUserId int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FactsetPortfolio_hst (
			FactSetPortfolioId, FundId, ReferenceDate, CurrencyId, InstrumentName, OriginalIdentifier, InstrumentMarketId, InstrumentClassId, FMContId, ReturnContribution, PriceReturnContribution, CurrencyReturnContribution, CarryReturnContribution, IsItd, StartDt, UpdateUserId, DataVersion, EndDt, LastActionUserID)
	SELECT	FactSetPortfolioId, FundId, ReferenceDate, CurrencyId, InstrumentName, OriginalIdentifier, InstrumentMarketId, InstrumentClassId, FMContId, ReturnContribution, PriceReturnContribution, CurrencyReturnContribution, CarryReturnContribution, IsItd, StartDt, UpdateUserId, DataVersion, @StartDt, @UpdateUserID
	FROM	FactsetPortfolio
	WHERE	FactSetPortfolioId = @FactSetPortfolioId

	UPDATE	FactsetPortfolio
	SET		FundId = @FundId, ReferenceDate = @ReferenceDate, CurrencyId = @CurrencyId, InstrumentName = @InstrumentName, OriginalIdentifier = @OriginalIdentifier, InstrumentMarketId = @InstrumentMarketId, InstrumentClassId = @InstrumentClassId, FMContId = @FMContId, ReturnContribution = @ReturnContribution, PriceReturnContribution = @PriceReturnContribution, CurrencyReturnContribution = @CurrencyReturnContribution, CarryReturnContribution = @CarryReturnContribution, IsItd = @IsItd, UpdateUserId = @UpdateUserId,  StartDt = @StartDt
	WHERE	FactSetPortfolioId = @FactSetPortfolioId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FactsetPortfolio
	WHERE	FactSetPortfolioId = @FactSetPortfolioId
	AND		@@ROWCOUNT > 0

GO
