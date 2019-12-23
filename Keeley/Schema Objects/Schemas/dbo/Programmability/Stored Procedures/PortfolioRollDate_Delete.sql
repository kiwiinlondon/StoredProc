USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioRollDate_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioRollDate_Delete]
GO

CREATE PROCEDURE DBO.[PortfolioRollDate_Delete]
		@PortfolioRollDateId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PortfolioRollDate_hst (
			PortfolioRollDateId, PortfolioAggregationLevelId, RollDate, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PortfolioRollDateId, PortfolioAggregationLevelId, RollDate, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	PortfolioRollDate
	WHERE	PortfolioRollDateId = @PortfolioRollDateId

	DELETE	PortfolioRollDate
	WHERE	PortfolioRollDateId = @PortfolioRollDateId
	AND		DataVersion = @DataVersion
GO
