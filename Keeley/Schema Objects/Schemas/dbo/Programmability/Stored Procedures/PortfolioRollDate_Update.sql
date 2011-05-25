USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioRollDate_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioRollDate_Update]
GO

CREATE PROCEDURE DBO.[PortfolioRollDate_Update]
		@PortfolioRollDateId int, 
		@PortfolioAggregationLevelId int, 
		@RollDate datetime, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PortfolioRollDate_hst (
			PortfolioRollDateId, PortfolioAggregationLevelId, RollDate, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PortfolioRollDateId, PortfolioAggregationLevelId, RollDate, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	PortfolioRollDate
	WHERE	PortfolioRollDateId = @PortfolioRollDateId

	UPDATE	PortfolioRollDate
	SET		PortfolioAggregationLevelId = @PortfolioAggregationLevelId, RollDate = @RollDate, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	PortfolioRollDateId = @PortfolioRollDateId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PortfolioRollDate
	WHERE	PortfolioRollDateId = @PortfolioRollDateId
	AND		@@ROWCOUNT > 0

GO
