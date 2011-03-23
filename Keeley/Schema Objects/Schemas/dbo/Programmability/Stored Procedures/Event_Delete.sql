USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Event_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Event_Delete]
GO

CREATE PROCEDURE DBO.[Event_Delete]
		@EventID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Event_hst (
			EventID, EventTypeID, StartDt, UpdateUserID, DataVersion, IdentifierTypeId, Identifier, EndDt, LastActionUserID)
	SELECT	EventID, EventTypeID, StartDt, UpdateUserID, DataVersion, IdentifierTypeId, Identifier, @EndDt, @UpdateUserID
	FROM	Event
	WHERE	EventID = @EventID

	DELETE	Event
	WHERE	EventID = @EventID
	AND		DataVersion = @DataVersion
GO
