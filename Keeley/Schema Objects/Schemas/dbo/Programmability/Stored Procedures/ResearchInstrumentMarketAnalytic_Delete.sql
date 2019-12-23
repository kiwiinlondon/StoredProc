USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ResearchInstrumentMarketAnalytic_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ResearchInstrumentMarketAnalytic_Delete]
GO

CREATE PROCEDURE DBO.[ResearchInstrumentMarketAnalytic_Delete]
		@ResearchInstrumentMarketAnalyticId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ResearchInstrumentMarketAnalytic_hst (
			ResearchInstrumentMarketAnalyticId, ResearchInstrumentMarketId, AnalyticTypeId, Value, StartDt, UpdateUserID, DataVersion, AsOfDt, EndDt, LastActionUserID)
	SELECT	ResearchInstrumentMarketAnalyticId, ResearchInstrumentMarketId, AnalyticTypeId, Value, StartDt, UpdateUserID, DataVersion, AsOfDt, @EndDt, @UpdateUserID
	FROM	ResearchInstrumentMarketAnalytic
	WHERE	ResearchInstrumentMarketAnalyticId = @ResearchInstrumentMarketAnalyticId

	DELETE	ResearchInstrumentMarketAnalytic
	WHERE	ResearchInstrumentMarketAnalyticId = @ResearchInstrumentMarketAnalyticId
	AND		DataVersion = @DataVersion
GO
