USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskParameter_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskParameter_Update]
GO

CREATE PROCEDURE DBO.[TaskParameter_Update]
		@TaskParameterId int, 
		@TaskId int, 
		@TaskParameterTypeId int, 
		@IntValue int, 
		@StringValue varchar(1000), 
		@DecimalValue numeric(27,8), 
		@DateTimeValue datetime, 
		@BitValue bit, 
		@IntValues varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO TaskParameter_hst (
			TaskParameterId, TaskId, TaskParameterTypeId, IntValue, StringValue, DecimalValue, DateTimeValue, BitValue, IntValues, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	TaskParameterId, TaskId, TaskParameterTypeId, IntValue, StringValue, DecimalValue, DateTimeValue, BitValue, IntValues, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	TaskParameter
	WHERE	TaskParameterId = @TaskParameterId

	UPDATE	TaskParameter
	SET		TaskId = @TaskId, TaskParameterTypeId = @TaskParameterTypeId, IntValue = @IntValue, StringValue = @StringValue, DecimalValue = @DecimalValue, DateTimeValue = @DateTimeValue, BitValue = @BitValue, IntValues = @IntValues, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	TaskParameterId = @TaskParameterId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	TaskParameter
	WHERE	TaskParameterId = @TaskParameterId
	AND		@@ROWCOUNT > 0

GO
