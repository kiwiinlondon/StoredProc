USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ResearchInstrumentMarketAnalytic_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ResearchInstrumentMarketAnalytic_Insert]
GO

CREATE PROCEDURE DBO.[ResearchInstrumentMarketAnalytic_Insert]
		@ResearchInstrumentMarketId int, 
		@AnalyticTypeId int, 
		@Value numeric(27,8), 
		@UpdateUserID int, 
		@AsOfDt datetime
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ResearchInstrumentMarketAnalytic
			(ResearchInstrumentMarketId, AnalyticTypeId, Value, UpdateUserID, AsOfDt, StartDt)
	VALUES
			(@ResearchInstrumentMarketId, @AnalyticTypeId, @Value, @UpdateUserID, @AsOfDt, @StartDt)

	SELECT	ResearchInstrumentMarketAnalyticId, StartDt, DataVersion
	FROM	ResearchInstrumentMarketAnalytic
	WHERE	ResearchInstrumentMarketAnalyticId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
