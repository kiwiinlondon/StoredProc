USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[MatchedStatus_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[MatchedStatus_Insert]
GO

CREATE PROCEDURE DBO.[MatchedStatus_Insert]
		@Code varchar(30), 
		@Name varchar(200), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into MatchedStatus
			(Code, Name, UpdateUserID, StartDt)
	VALUES
			(@Code, @Name, @UpdateUserID, @StartDt)

	SELECT	MatchedStatusID, StartDt, DataVersion
	FROM	MatchedStatus
	WHERE	MatchedStatusID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
