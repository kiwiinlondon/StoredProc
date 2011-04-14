USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InternalAccountingEventType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InternalAccountingEventType_Delete]
GO

CREATE PROCEDURE DBO.[InternalAccountingEventType_Delete]
		@InternalAccountingEventTypeID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO InternalAccountingEventType_hst (
			InternalAccountingEventTypeID, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	InternalAccountingEventTypeID, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	InternalAccountingEventType
	WHERE	InternalAccountingEventTypeID = @InternalAccountingEventTypeID

	DELETE	InternalAccountingEventType
	WHERE	InternalAccountingEventTypeID = @InternalAccountingEventTypeID
	AND		DataVersion = @DataVersion
GO
