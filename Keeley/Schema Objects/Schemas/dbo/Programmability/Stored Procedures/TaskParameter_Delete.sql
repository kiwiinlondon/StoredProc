USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskParameter_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskParameter_Delete]
GO

CREATE PROCEDURE DBO.[TaskParameter_Delete]
		@TaskParameterId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO TaskParameter_hst (
			TaskParameterId, TaskId, TaskParameterTypeId, IntValue, StringValue, DecimalValue, DateTimeValue, BitValue, IntValues, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	TaskParameterId, TaskId, TaskParameterTypeId, IntValue, StringValue, DecimalValue, DateTimeValue, BitValue, IntValues, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	TaskParameter
	WHERE	TaskParameterId = @TaskParameterId

	DELETE	TaskParameter
	WHERE	TaskParameterId = @TaskParameterId
	AND		DataVersion = @DataVersion
GO
