USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioPositionAccountTradeDate_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioPositionAccountTradeDate_Insert]
GO

CREATE PROCEDURE DBO.[PortfolioPositionAccountTradeDate_Insert]
		@PositionAccountID int, 
		@ReferenceDate datetime, 
		@Quantity numeric(27,8), 
		@TotalCost numeric(27,8), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PortfolioPositionAccountTradeDate
			(PositionAccountID, ReferenceDate, Quantity, TotalCost, UpdateUserID, StartDt)
	VALUES
			(@PositionAccountID, @ReferenceDate, @Quantity, @TotalCost, @UpdateUserID, @StartDt)

	SELECT	PortfolioPositionAccountTradeDateId, StartDt, DataVersion
	FROM	PortfolioPositionAccountTradeDate
	WHERE	PortfolioPositionAccountTradeDateId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
