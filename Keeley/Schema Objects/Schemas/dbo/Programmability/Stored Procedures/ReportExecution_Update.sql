USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ReportExecution_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ReportExecution_Update]
GO

CREATE PROCEDURE DBO.[ReportExecution_Update]
		@ReportExecutionId int, 
		@ClientGuid varchar(256), 
		@FundIds varchar(256), 
		@BenchmarkInstrumentIds varchar(256), 
		@StartDate datetime, 
		@EndDate datetime, 
		@ReportDefinitionId int, 
		@ExecutionStartDt datetime, 
		@ExecutionEndDt datetime, 
		@ExecutionElapsedTime datetime, 
		@TableCount int, 
		@TablesLoadedFromDiskCount int, 
		@RowsApplied int, 
		@Notifications varchar(-1), 
		@HasErrors bit, 
		@IsContinuous bit, 
		@ReportStatusId int, 
		@DataVersion rowversion, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ReportExecution_hst (
			ReportExecutionId, ClientGuid, FundIds, BenchmarkInstrumentIds, StartDate, EndDate, ReportDefinitionId, ExecutionStartDt, ExecutionEndDt, ExecutionElapsedTime, TableCount, TablesLoadedFromDiskCount, RowsApplied, Notifications, HasErrors, IsContinuous, ReportStatusId, StartDt, DataVersion, UpdateUserID, EndDt, LastActionUserID)
	SELECT	ReportExecutionId, ClientGuid, FundIds, BenchmarkInstrumentIds, StartDate, EndDate, ReportDefinitionId, ExecutionStartDt, ExecutionEndDt, ExecutionElapsedTime, TableCount, TablesLoadedFromDiskCount, RowsApplied, Notifications, HasErrors, IsContinuous, ReportStatusId, StartDt, DataVersion, UpdateUserID, @StartDt, @UpdateUserID
	FROM	ReportExecution
	WHERE	ReportExecutionId = @ReportExecutionId

	UPDATE	ReportExecution
	SET		ClientGuid = @ClientGuid, FundIds = @FundIds, BenchmarkInstrumentIds = @BenchmarkInstrumentIds, StartDate = @StartDate, EndDate = @EndDate, ReportDefinitionId = @ReportDefinitionId, ExecutionStartDt = @ExecutionStartDt, ExecutionEndDt = @ExecutionEndDt, ExecutionElapsedTime = @ExecutionElapsedTime, TableCount = @TableCount, TablesLoadedFromDiskCount = @TablesLoadedFromDiskCount, RowsApplied = @RowsApplied, Notifications = @Notifications, HasErrors = @HasErrors, IsContinuous = @IsContinuous, ReportStatusId = @ReportStatusId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ReportExecutionId = @ReportExecutionId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ReportExecution
	WHERE	ReportExecutionId = @ReportExecutionId
	AND		@@ROWCOUNT > 0

GO
