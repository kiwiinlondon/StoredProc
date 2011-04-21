USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EventField_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EventField_Update]
GO

CREATE PROCEDURE DBO.[EventField_Update]
		@EventFieldID int, 
		@EventTypeId int, 
		@FieldOnInternalAllocaion bit, 
		@Name varchar(70), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO EventField_hst (
			EventFieldID, EventTypeId, FieldOnInternalAllocaion, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EventFieldID, EventTypeId, FieldOnInternalAllocaion, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	EventField
	WHERE	EventFieldID = @EventFieldID

	UPDATE	EventField
	SET		EventTypeId = @EventTypeId, FieldOnInternalAllocaion = @FieldOnInternalAllocaion, Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	EventFieldID = @EventFieldID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	EventField
	WHERE	EventFieldID = @EventFieldID
	AND		@@ROWCOUNT > 0

GO
