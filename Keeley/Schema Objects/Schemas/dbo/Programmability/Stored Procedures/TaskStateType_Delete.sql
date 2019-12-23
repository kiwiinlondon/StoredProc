USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskStateType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskStateType_Delete]
GO

CREATE PROCEDURE DBO.[TaskStateType_Delete]
		@TaskStateTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO TaskStateType_hst (
			TaskStateTypeId, Name, StartDt, UpdateUserID, DataVersion, Description, EndDt, LastActionUserID)
	SELECT	TaskStateTypeId, Name, StartDt, UpdateUserID, DataVersion, Description, @EndDt, @UpdateUserID
	FROM	TaskStateType
	WHERE	TaskStateTypeId = @TaskStateTypeId

	DELETE	TaskStateType
	WHERE	TaskStateTypeId = @TaskStateTypeId
	AND		DataVersion = @DataVersion
GO
