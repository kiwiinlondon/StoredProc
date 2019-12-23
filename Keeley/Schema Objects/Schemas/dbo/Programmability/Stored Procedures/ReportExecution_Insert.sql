USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ReportExecution_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ReportExecution_Insert]
GO

CREATE PROCEDURE DBO.[ReportExecution_Insert]
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
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ReportExecution
			(ClientGuid, FundIds, BenchmarkInstrumentIds, StartDate, EndDate, ReportDefinitionId, ExecutionStartDt, ExecutionEndDt, ExecutionElapsedTime, TableCount, TablesLoadedFromDiskCount, RowsApplied, Notifications, HasErrors, IsContinuous, ReportStatusId, UpdateUserID, StartDt)
	VALUES
			(@ClientGuid, @FundIds, @BenchmarkInstrumentIds, @StartDate, @EndDate, @ReportDefinitionId, @ExecutionStartDt, @ExecutionEndDt, @ExecutionElapsedTime, @TableCount, @TablesLoadedFromDiskCount, @RowsApplied, @Notifications, @HasErrors, @IsContinuous, @ReportStatusId, @UpdateUserID, @StartDt)

	SELECT	ReportExecutionId, StartDt, DataVersion
	FROM	ReportExecution
	WHERE	ReportExecutionId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
