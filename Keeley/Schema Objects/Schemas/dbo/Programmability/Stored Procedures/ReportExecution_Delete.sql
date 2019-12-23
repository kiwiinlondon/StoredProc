USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ReportExecution_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ReportExecution_Delete]
GO

CREATE PROCEDURE DBO.[ReportExecution_Delete]
		@ReportExecutionId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ReportExecution_hst (
			ReportExecutionId, ClientGuid, FundIds, BenchmarkInstrumentIds, StartDate, EndDate, ReportDefinitionId, ExecutionStartDt, ExecutionEndDt, ExecutionElapsedTime, TableCount, TablesLoadedFromDiskCount, RowsApplied, Notifications, HasErrors, IsContinuous, ReportStatusId, StartDt, DataVersion, UpdateUserID, EndDt, LastActionUserID)
	SELECT	ReportExecutionId, ClientGuid, FundIds, BenchmarkInstrumentIds, StartDate, EndDate, ReportDefinitionId, ExecutionStartDt, ExecutionEndDt, ExecutionElapsedTime, TableCount, TablesLoadedFromDiskCount, RowsApplied, Notifications, HasErrors, IsContinuous, ReportStatusId, StartDt, DataVersion, UpdateUserID, @EndDt, @UpdateUserID
	FROM	ReportExecution
	WHERE	ReportExecutionId = @ReportExecutionId

	DELETE	ReportExecution
	WHERE	ReportExecutionId = @ReportExecutionId
	AND		DataVersion = @DataVersion
GO
