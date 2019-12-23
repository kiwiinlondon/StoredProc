USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioAggregationLevel_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioAggregationLevel_Update]
GO

CREATE PROCEDURE DBO.[PortfolioAggregationLevel_Update]
		@PortfolioAggregationLevelId int, 
		@Name varchar(50), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PortfolioAggregationLevel_hst (
			PortfolioAggregationLevelId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PortfolioAggregationLevelId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	PortfolioAggregationLevel
	WHERE	PortfolioAggregationLevelId = @PortfolioAggregationLevelId

	UPDATE	PortfolioAggregationLevel
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	PortfolioAggregationLevelId = @PortfolioAggregationLevelId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PortfolioAggregationLevel
	WHERE	PortfolioAggregationLevelId = @PortfolioAggregationLevelId
	AND		@@ROWCOUNT > 0

GO
