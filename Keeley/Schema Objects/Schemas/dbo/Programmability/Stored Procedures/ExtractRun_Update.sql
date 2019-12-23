USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractRun_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractRun_Update]
GO

CREATE PROCEDURE DBO.[ExtractRun_Update]
		@ExtractRunId int, 
		@ExtractId int, 
		@RunTime datetime, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@InProgress bit, 
		@NumberRecords int, 
		@FilePath varchar(100), 
		@RuntimeParameters varchar(1000)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ExtractRun_hst (
			ExtractRunId, ExtractId, RunTime, StartDt, UpdateUserID, DataVersion, InProgress, NumberRecords, FilePath, RuntimeParameters, EndDt, LastActionUserID)
	SELECT	ExtractRunId, ExtractId, RunTime, StartDt, UpdateUserID, DataVersion, InProgress, NumberRecords, FilePath, RuntimeParameters, @StartDt, @UpdateUserID
	FROM	ExtractRun
	WHERE	ExtractRunId = @ExtractRunId

	UPDATE	ExtractRun
	SET		ExtractId = @ExtractId, RunTime = @RunTime, UpdateUserID = @UpdateUserID, InProgress = @InProgress, NumberRecords = @NumberRecords, FilePath = @FilePath, RuntimeParameters = @RuntimeParameters,  StartDt = @StartDt
	WHERE	ExtractRunId = @ExtractRunId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ExtractRun
	WHERE	ExtractRunId = @ExtractRunId
	AND		@@ROWCOUNT > 0

GO
