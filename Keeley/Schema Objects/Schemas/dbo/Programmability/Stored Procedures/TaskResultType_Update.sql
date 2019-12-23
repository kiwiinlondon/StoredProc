USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskResultType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskResultType_Update]
GO

CREATE PROCEDURE DBO.[TaskResultType_Update]
		@TaskResultTypeId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO TaskResultType_hst (
			TaskResultTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	TaskResultTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	TaskResultType
	WHERE	TaskResultTypeId = @TaskResultTypeId

	UPDATE	TaskResultType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	TaskResultTypeId = @TaskResultTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	TaskResultType
	WHERE	TaskResultTypeId = @TaskResultTypeId
	AND		@@ROWCOUNT > 0

GO
