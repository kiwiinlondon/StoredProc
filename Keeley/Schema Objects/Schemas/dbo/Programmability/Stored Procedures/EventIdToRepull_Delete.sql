USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EventIdToRepull_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EventIdToRepull_Delete]
GO

CREATE PROCEDURE DBO.[EventIdToRepull_Delete]
		@EventId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO EventIdToRepull_hst (
			EventId, EndDt, LastActionUserID)
	SELECT	EventId, @EndDt, @UpdateUserID
	FROM	EventIdToRepull
	WHERE	EventId = @EventId

	DELETE	EventIdToRepull
	WHERE	EventId = @EventId
	AND		DataVersion = @DataVersion
GO
