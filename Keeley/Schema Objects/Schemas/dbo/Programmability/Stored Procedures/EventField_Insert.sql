USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EventField_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EventField_Insert]
GO

CREATE PROCEDURE DBO.[EventField_Insert]
		@EventTypeId int, 
		@FieldOnInternalAllocaion bit, 
		@Name varchar(70), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into EventField
			(EventTypeId, FieldOnInternalAllocaion, Name, UpdateUserID, StartDt)
	VALUES
			(@EventTypeId, @FieldOnInternalAllocaion, @Name, @UpdateUserID, @StartDt)

	SELECT	EventFieldID, StartDt, DataVersion
	FROM	EventField
	WHERE	EventFieldID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
