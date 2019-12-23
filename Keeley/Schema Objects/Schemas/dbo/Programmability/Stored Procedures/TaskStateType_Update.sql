USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskStateType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskStateType_Update]
GO

CREATE PROCEDURE DBO.[TaskStateType_Update]
		@TaskStateTypeId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@Description varchar(1000)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO TaskStateType_hst (
			TaskStateTypeId, Name, StartDt, UpdateUserID, DataVersion, Description, EndDt, LastActionUserID)
	SELECT	TaskStateTypeId, Name, StartDt, UpdateUserID, DataVersion, Description, @StartDt, @UpdateUserID
	FROM	TaskStateType
	WHERE	TaskStateTypeId = @TaskStateTypeId

	UPDATE	TaskStateType
	SET		Name = @Name, UpdateUserID = @UpdateUserID, Description = @Description,  StartDt = @StartDt
	WHERE	TaskStateTypeId = @TaskStateTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	TaskStateType
	WHERE	TaskStateTypeId = @TaskStateTypeId
	AND		@@ROWCOUNT > 0

GO
