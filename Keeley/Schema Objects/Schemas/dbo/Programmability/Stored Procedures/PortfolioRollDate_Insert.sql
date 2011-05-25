USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioRollDate_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioRollDate_Insert]
GO

CREATE PROCEDURE DBO.[PortfolioRollDate_Insert]
		@PortfolioAggregationLevelId int, 
		@RollDate datetime, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PortfolioRollDate
			(PortfolioAggregationLevelId, RollDate, UpdateUserID, StartDt)
	VALUES
			(@PortfolioAggregationLevelId, @RollDate, @UpdateUserID, @StartDt)

	SELECT	PortfolioRollDateId, StartDt, DataVersion
	FROM	PortfolioRollDate
	WHERE	PortfolioRollDateId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
