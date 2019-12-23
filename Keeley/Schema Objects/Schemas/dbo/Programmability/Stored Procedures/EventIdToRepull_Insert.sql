USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EventIdToRepull_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EventIdToRepull_Insert]
GO

CREATE PROCEDURE DBO.[EventIdToRepull_Insert]
		@EventId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into EventIdToRepull
			(EventId, StartDt)
	VALUES
			(@EventId, @StartDt)

	SELECT	EventId, StartDt, DataVersion
	FROM	EventIdToRepull
	WHERE	EventId = @EventId
	AND		@@ROWCOUNT > 0

GO
