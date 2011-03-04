USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioChangeControl_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioChangeControl_Update]
GO

CREATE PROCEDURE DBO.[PortfolioChangeControl_Update]
		@PortfolioChangeControlId int, 
		@PositionID int, 
		@StrategyID int, 
		@TradeTypeID int, 
		@ReferenceDate date, 
		@ChangeId int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PortfolioChangeControl_hst (
			PortfolioChangeControlId, PositionID, StrategyID, TradeTypeID, ReferenceDate, ChangeId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PortfolioChangeControlId, PositionID, StrategyID, TradeTypeID, ReferenceDate, ChangeId, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	PortfolioChangeControl
	WHERE	PortfolioChangeControlId = @PortfolioChangeControlId

	UPDATE	PortfolioChangeControl
	SET		PositionID = @PositionID, StrategyID = @StrategyID, TradeTypeID = @TradeTypeID, ReferenceDate = @ReferenceDate, ChangeId = @ChangeId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	PortfolioChangeControlId = @PortfolioChangeControlId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PortfolioChangeControl
	WHERE	PortfolioChangeControlId = @PortfolioChangeControlId
	AND		@@ROWCOUNT > 0

GO
