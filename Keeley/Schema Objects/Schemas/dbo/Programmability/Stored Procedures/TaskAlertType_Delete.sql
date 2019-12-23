USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskAlertType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskAlertType_Delete]
GO

CREATE PROCEDURE DBO.[TaskAlertType_Delete]
		@TaskAlertTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO TaskAlertType_hst (
			TaskAlertTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	TaskAlertTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	TaskAlertType
	WHERE	TaskAlertTypeId = @TaskAlertTypeId

	DELETE	TaskAlertType
	WHERE	TaskAlertTypeId = @TaskAlertTypeId
	AND		DataVersion = @DataVersion
GO
