USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractRun_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractRun_Insert]
GO

CREATE PROCEDURE DBO.[ExtractRun_Insert]
		@ExtractId int, 
		@RunTime datetime, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ExtractRun
			(ExtractId, RunTime, UpdateUserID, StartDt)
	VALUES
			(@ExtractId, @RunTime, @UpdateUserID, @StartDt)

	SELECT	ExtractRunId, StartDt, DataVersion
	FROM	ExtractRun
	WHERE	ExtractRunId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
