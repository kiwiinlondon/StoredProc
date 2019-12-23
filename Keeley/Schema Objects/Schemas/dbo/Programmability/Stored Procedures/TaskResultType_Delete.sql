USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskResultType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskResultType_Delete]
GO

CREATE PROCEDURE DBO.[TaskResultType_Delete]
		@TaskResultTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO TaskResultType_hst (
			TaskResultTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	TaskResultTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	TaskResultType
	WHERE	TaskResultTypeId = @TaskResultTypeId

	DELETE	TaskResultType
	WHERE	TaskResultTypeId = @TaskResultTypeId
	AND		DataVersion = @DataVersion
GO
