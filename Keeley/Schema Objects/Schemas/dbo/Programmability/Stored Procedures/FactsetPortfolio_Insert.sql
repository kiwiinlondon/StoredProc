USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FactsetPortfolio_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FactsetPortfolio_Insert]
GO

CREATE PROCEDURE DBO.[FactsetPortfolio_Insert]
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
		@UpdateUserId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FactsetPortfolio
			(FundId, ReferenceDate, CurrencyId, InstrumentName, OriginalIdentifier, InstrumentMarketId, InstrumentClassId, FMContId, ReturnContribution, PriceReturnContribution, CurrencyReturnContribution, CarryReturnContribution, IsItd, UpdateUserId, StartDt)
	VALUES
			(@FundId, @ReferenceDate, @CurrencyId, @InstrumentName, @OriginalIdentifier, @InstrumentMarketId, @InstrumentClassId, @FMContId, @ReturnContribution, @PriceReturnContribution, @CurrencyReturnContribution, @CarryReturnContribution, @IsItd, @UpdateUserId, @StartDt)

	SELECT	FactSetPortfolioId, StartDt, DataVersion
	FROM	FactsetPortfolio
	WHERE	FactSetPortfolioId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
