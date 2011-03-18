USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioPositionAccountTradeDate_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioPositionAccountTradeDate_Update]
GO

CREATE PROCEDURE DBO.[PortfolioPositionAccountTradeDate_Update]
		@PortfolioPositionAccountTradeDateId int, 
		@PositionAccountID int, 
		@ReferenceDate datetime, 
		@Quantity numeric(27,8), 
		@TotalCost numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PortfolioPositionAccountTradeDate_hst (
			PortfolioPositionAccountTradeDateId, PositionAccountID, ReferenceDate, Quantity, TotalCost, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PortfolioPositionAccountTradeDateId, PositionAccountID, ReferenceDate, Quantity, TotalCost, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	PortfolioPositionAccountTradeDate
	WHERE	PortfolioPositionAccountTradeDateId = @PortfolioPositionAccountTradeDateId

	UPDATE	PortfolioPositionAccountTradeDate
	SET		PositionAccountID = @PositionAccountID, ReferenceDate = @ReferenceDate, Quantity = @Quantity, TotalCost = @TotalCost, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	PortfolioPositionAccountTradeDateId = @PortfolioPositionAccountTradeDateId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PortfolioPositionAccountTradeDate
	WHERE	PortfolioPositionAccountTradeDateId = @PortfolioPositionAccountTradeDateId
	AND		@@ROWCOUNT > 0

GO
