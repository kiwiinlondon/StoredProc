USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioChangeControl_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioChangeControl_Delete]
GO

CREATE PROCEDURE DBO.[PortfolioChangeControl_Delete]
		@PortfolioChangeControlId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PortfolioChangeControl_hst (
			PortfolioChangeControlId, PositionID, StrategyID, TradeTypeID, ReferenceDate, ChangeId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PortfolioChangeControlId, PositionID, StrategyID, TradeTypeID, ReferenceDate, ChangeId, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	PortfolioChangeControl
	WHERE	PortfolioChangeControlId = @PortfolioChangeControlId

	DELETE	PortfolioChangeControl
	WHERE	PortfolioChangeControlId = @PortfolioChangeControlId
	AND		DataVersion = @DataVersion
GO
