USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InternalAccountingEventType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InternalAccountingEventType_Update]
GO

CREATE PROCEDURE DBO.[InternalAccountingEventType_Update]
		@InternalAccountingEventTypeID int, 
		@Name varchar(70), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO InternalAccountingEventType_hst (
			InternalAccountingEventTypeID, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	InternalAccountingEventTypeID, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	InternalAccountingEventType
	WHERE	InternalAccountingEventTypeID = @InternalAccountingEventTypeID

	UPDATE	InternalAccountingEventType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	InternalAccountingEventTypeID = @InternalAccountingEventTypeID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	InternalAccountingEventType
	WHERE	InternalAccountingEventTypeID = @InternalAccountingEventTypeID
	AND		@@ROWCOUNT > 0

GO
