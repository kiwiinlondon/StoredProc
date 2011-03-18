USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioPositionAccountTradeDate_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioPositionAccountTradeDate_Delete]
GO

CREATE PROCEDURE DBO.[PortfolioPositionAccountTradeDate_Delete]
		@PortfolioPositionAccountTradeDateId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PortfolioPositionAccountTradeDate_hst (
			PortfolioPositionAccountTradeDateId, PositionAccountID, ReferenceDate, Quantity, TotalCost, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PortfolioPositionAccountTradeDateId, PositionAccountID, ReferenceDate, Quantity, TotalCost, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	PortfolioPositionAccountTradeDate
	WHERE	PortfolioPositionAccountTradeDateId = @PortfolioPositionAccountTradeDateId

	DELETE	PortfolioPositionAccountTradeDate
	WHERE	PortfolioPositionAccountTradeDateId = @PortfolioPositionAccountTradeDateId
	AND		DataVersion = @DataVersion
GO
