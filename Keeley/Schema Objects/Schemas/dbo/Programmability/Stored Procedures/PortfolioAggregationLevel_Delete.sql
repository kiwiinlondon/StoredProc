USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioAggregationLevel_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioAggregationLevel_Delete]
GO

CREATE PROCEDURE DBO.[PortfolioAggregationLevel_Delete]
		@PortfolioAggregationLevelId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PortfolioAggregationLevel_hst (
			PortfolioAggregationLevelId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PortfolioAggregationLevelId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	PortfolioAggregationLevel
	WHERE	PortfolioAggregationLevelId = @PortfolioAggregationLevelId

	DELETE	PortfolioAggregationLevel
	WHERE	PortfolioAggregationLevelId = @PortfolioAggregationLevelId
	AND		DataVersion = @DataVersion
GO
