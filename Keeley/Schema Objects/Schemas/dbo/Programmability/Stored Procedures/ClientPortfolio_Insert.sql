USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientPortfolio_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientPortfolio_Insert]
GO

CREATE PROCEDURE DBO.[ClientPortfolio_Insert]
		@ClientAccountId int, 
		@FundId int, 
		@ReferenceDate datetime, 
		@Quantity numeric(27,8), 
		@ChangeInQuantity numeric(27,8), 
		@MarketValue numeric(27,8), 
		@PriceId int, 
		@Price numeric(27,8), 
		@Cost numeric(27,8), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ClientPortfolio
			(ClientAccountId, FundId, ReferenceDate, Quantity, ChangeInQuantity, MarketValue, PriceId, Price, Cost, UpdateUserID, StartDt)
	VALUES
			(@ClientAccountId, @FundId, @ReferenceDate, @Quantity, @ChangeInQuantity, @MarketValue, @PriceId, @Price, @Cost, @UpdateUserID, @StartDt)

	SELECT	ClientPortfolioId, StartDt, DataVersion
	FROM	ClientPortfolio
	WHERE	ClientPortfolioId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
