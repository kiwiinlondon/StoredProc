USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EventField_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EventField_Delete]
GO

CREATE PROCEDURE DBO.[EventField_Delete]
		@EventFieldID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO EventField_hst (
			EventFieldID, EventTypeId, FieldOnInternalAllocaion, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EventFieldID, EventTypeId, FieldOnInternalAllocaion, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	EventField
	WHERE	EventFieldID = @EventFieldID

	DELETE	EventField
	WHERE	EventFieldID = @EventFieldID
	AND		DataVersion = @DataVersion
GO
