USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractGroup_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractGroup_Insert]
GO

CREATE PROCEDURE DBO.[ExtractGroup_Insert]
		@ExtractRunnerTypeId int, 
		@Name varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ExtractGroup
			(ExtractRunnerTypeId, Name, UpdateUserID, StartDt)
	VALUES
			(@ExtractRunnerTypeId, @Name, @UpdateUserID, @StartDt)

	SELECT	ExtractGroupId, StartDt, DataVersion
	FROM	ExtractGroup
	WHERE	ExtractGroupId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
