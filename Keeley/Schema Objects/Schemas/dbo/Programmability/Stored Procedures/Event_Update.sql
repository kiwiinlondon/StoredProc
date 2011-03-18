USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Event_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Event_Update]
GO

CREATE PROCEDURE DBO.[Event_Update]
		@EventID int, 
		@EventTypeID int, 
		@IsCancelled bit, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Event_hst (
			EventID, EventTypeID, IsCancelled, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EventID, EventTypeID, IsCancelled, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	Event
	WHERE	EventID = @EventID

	UPDATE	Event
	SET		EventTypeID = @EventTypeID, IsCancelled = @IsCancelled, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	EventID = @EventID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Event
	WHERE	EventID = @EventID
	AND		@@ROWCOUNT > 0

GO
