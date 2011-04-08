USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioAggregationLevel_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioAggregationLevel_Insert]
GO

CREATE PROCEDURE DBO.[PortfolioAggregationLevel_Insert]
		@Name varchar(50), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PortfolioAggregationLevel
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	PortfolioAggregationLevelId, StartDt, DataVersion
	FROM	PortfolioAggregationLevel
	WHERE	PortfolioAggregationLevelId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
