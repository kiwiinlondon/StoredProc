USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EventType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EventType_Update]
GO

CREATE PROCEDURE DBO.[EventType_Update]
		@EventTypeID int, 
		@Name varchar(70), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO EventType_hst (
			EventTypeID, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EventTypeID, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	EventType
	WHERE	EventTypeID = @EventTypeID

	UPDATE	EventType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	EventTypeID = @EventTypeID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	EventType
	WHERE	EventTypeID = @EventTypeID
	AND		@@ROWCOUNT > 0

GO
