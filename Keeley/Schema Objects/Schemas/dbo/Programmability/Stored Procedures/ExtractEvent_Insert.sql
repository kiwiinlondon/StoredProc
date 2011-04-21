USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractEvent_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractEvent_Insert]
GO

CREATE PROCEDURE DBO.[ExtractEvent_Insert]
		@ExtractId int, 
		@EventId int, 
		@LastSentInExtractRunId int, 
		@SendInNextRun bit, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ExtractEvent
			(ExtractId, EventId, LastSentInExtractRunId, SendInNextRun, UpdateUserID, StartDt)
	VALUES
			(@ExtractId, @EventId, @LastSentInExtractRunId, @SendInNextRun, @UpdateUserID, @StartDt)

	SELECT	ExtractEventID, StartDt, DataVersion
	FROM	ExtractEvent
	WHERE	ExtractEventID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
