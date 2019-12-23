USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskType_Update]
GO

CREATE PROCEDURE DBO.[TaskType_Update]
		@TaskTypeId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO TaskType_hst (
			TaskTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	TaskTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	TaskType
	WHERE	TaskTypeId = @TaskTypeId

	UPDATE	TaskType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	TaskTypeId = @TaskTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	TaskType
	WHERE	TaskTypeId = @TaskTypeId
	AND		@@ROWCOUNT > 0

GO
