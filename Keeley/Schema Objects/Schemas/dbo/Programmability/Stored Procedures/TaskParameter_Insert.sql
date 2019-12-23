USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskParameter_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskParameter_Insert]
GO

CREATE PROCEDURE DBO.[TaskParameter_Insert]
		@TaskId int, 
		@TaskParameterTypeId int, 
		@IntValue int, 
		@StringValue varchar(1000), 
		@DecimalValue numeric(27,8), 
		@DateTimeValue datetime, 
		@BitValue bit, 
		@IntValues varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into TaskParameter
			(TaskId, TaskParameterTypeId, IntValue, StringValue, DecimalValue, DateTimeValue, BitValue, IntValues, UpdateUserID, StartDt)
	VALUES
			(@TaskId, @TaskParameterTypeId, @IntValue, @StringValue, @DecimalValue, @DateTimeValue, @BitValue, @IntValues, @UpdateUserID, @StartDt)

	SELECT	TaskParameterId, StartDt, DataVersion
	FROM	TaskParameter
	WHERE	TaskParameterId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
