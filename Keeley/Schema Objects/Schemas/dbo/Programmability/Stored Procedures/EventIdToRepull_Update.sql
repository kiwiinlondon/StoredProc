USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EventIdToRepull_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EventIdToRepull_Update]
GO

CREATE PROCEDURE DBO.[EventIdToRepull_Update]
		@EventId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO EventIdToRepull_hst (
			EventId, EndDt, LastActionUserID)
	SELECT	EventId, @StartDt, @UpdateUserID
	FROM	EventIdToRepull
	WHERE	EventId = @EventId

	UPDATE	EventIdToRepull
	SET		 StartDt = @StartDt
	WHERE	EventId = @EventId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	EventIdToRepull
	WHERE	EventId = @EventId
	AND		@@ROWCOUNT > 0

GO
