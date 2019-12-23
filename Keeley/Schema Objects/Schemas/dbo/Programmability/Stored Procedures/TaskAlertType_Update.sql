USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskAlertType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskAlertType_Update]
GO

CREATE PROCEDURE DBO.[TaskAlertType_Update]
		@TaskAlertTypeId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO TaskAlertType_hst (
			TaskAlertTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	TaskAlertTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	TaskAlertType
	WHERE	TaskAlertTypeId = @TaskAlertTypeId

	UPDATE	TaskAlertType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	TaskAlertTypeId = @TaskAlertTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	TaskAlertType
	WHERE	TaskAlertTypeId = @TaskAlertTypeId
	AND		@@ROWCOUNT > 0

GO
