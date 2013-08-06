USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FileToBeCollectedGroup_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FileToBeCollectedGroup_Insert]
GO

CREATE PROCEDURE DBO.[FileToBeCollectedGroup_Insert]
		@Name varchar(200), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FileToBeCollectedGroup
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	FilesToBeCollectedGroupId, StartDt, DataVersion
	FROM	FileToBeCollectedGroup
	WHERE	FilesToBeCollectedGroupId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
