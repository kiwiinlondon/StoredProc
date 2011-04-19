USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Event_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Event_Insert]
GO

CREATE PROCEDURE DBO.[Event_Insert]
		@EventTypeID int, 
		@UpdateUserID int, 
		@IdentifierTypeId int, 
		@Identifier varchar(100), 
		@IsTopLevel bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Event
			(EventTypeID, UpdateUserID, IdentifierTypeId, Identifier, IsTopLevel, StartDt)
	VALUES
			(@EventTypeID, @UpdateUserID, @IdentifierTypeId, @Identifier, @IsTopLevel, @StartDt)

	SELECT	EventID, StartDt, DataVersion
	FROM	Event
	WHERE	EventID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
