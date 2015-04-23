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
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@IdentifierTypeId int, 
		@Identifier varchar(128), 
		@IsTopLevel bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Event_hst (
			EventID, EventTypeID, StartDt, UpdateUserID, DataVersion, IdentifierTypeId, Identifier, IsTopLevel, EndDt, LastActionUserID)
	SELECT	EventID, EventTypeID, StartDt, UpdateUserID, DataVersion, IdentifierTypeId, Identifier, IsTopLevel, @StartDt, @UpdateUserID
	FROM	Event
	WHERE	EventID = @EventID

	UPDATE	Event
	SET		EventTypeID = @EventTypeID, UpdateUserID = @UpdateUserID, IdentifierTypeId = @IdentifierTypeId, Identifier = @Identifier, IsTopLevel = @IsTopLevel,  StartDt = @StartDt
	WHERE	EventID = @EventID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Event
	WHERE	EventID = @EventID
	AND		@@ROWCOUNT > 0

GO
