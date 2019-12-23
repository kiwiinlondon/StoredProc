USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractRun_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractRun_Delete]
GO

CREATE PROCEDURE DBO.[ExtractRun_Delete]
		@ExtractRunId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ExtractRun_hst (
			ExtractRunId, ExtractId, RunTime, StartDt, UpdateUserID, DataVersion, InProgress, NumberRecords, FilePath, RuntimeParameters, EndDt, LastActionUserID)
	SELECT	ExtractRunId, ExtractId, RunTime, StartDt, UpdateUserID, DataVersion, InProgress, NumberRecords, FilePath, RuntimeParameters, @EndDt, @UpdateUserID
	FROM	ExtractRun
	WHERE	ExtractRunId = @ExtractRunId

	DELETE	ExtractRun
	WHERE	ExtractRunId = @ExtractRunId
	AND		DataVersion = @DataVersion
GO
