USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EventType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EventType_Insert]
GO

CREATE PROCEDURE DBO.[EventType_Insert]
		@Name varchar(70), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into EventType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	EventTypeID, StartDt, DataVersion
	FROM	EventType
	WHERE	EventTypeID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
