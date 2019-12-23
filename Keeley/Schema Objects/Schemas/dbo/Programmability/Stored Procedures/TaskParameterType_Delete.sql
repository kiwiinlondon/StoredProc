USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskParameterType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskParameterType_Delete]
GO

CREATE PROCEDURE DBO.[TaskParameterType_Delete]
		@TaskParameterTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO TaskParameterType_hst (
			TaskParameterTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	TaskParameterTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	TaskParameterType
	WHERE	TaskParameterTypeId = @TaskParameterTypeId

	DELETE	TaskParameterType
	WHERE	TaskParameterTypeId = @TaskParameterTypeId
	AND		DataVersion = @DataVersion
GO
