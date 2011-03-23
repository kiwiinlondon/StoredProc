USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[BuySellReason_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[BuySellReason_Insert]
GO

CREATE PROCEDURE DBO.[BuySellReason_Insert]
		@Code varchar(30), 
		@Name varchar(200), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into BuySellReason
			(Code, Name, UpdateUserID, StartDt)
	VALUES
			(@Code, @Name, @UpdateUserID, @StartDt)

	SELECT	BuySellReasonID, StartDt, DataVersion
	FROM	BuySellReason
	WHERE	BuySellReasonID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
