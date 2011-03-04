USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioChangeControl_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioChangeControl_Insert]
GO

CREATE PROCEDURE DBO.[PortfolioChangeControl_Insert]
		@PositionID int, 
		@StrategyID int, 
		@TradeTypeID int, 
		@ReferenceDate date, 
		@ChangeId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PortfolioChangeControl
			(PositionID, StrategyID, TradeTypeID, ReferenceDate, ChangeId, UpdateUserID, StartDt)
	VALUES
			(@PositionID, @StrategyID, @TradeTypeID, @ReferenceDate, @ChangeId, @UpdateUserID, @StartDt)

	SELECT	PortfolioChangeControlId, StartDt, DataVersion
	FROM	PortfolioChangeControl
	WHERE	PortfolioChangeControlId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
