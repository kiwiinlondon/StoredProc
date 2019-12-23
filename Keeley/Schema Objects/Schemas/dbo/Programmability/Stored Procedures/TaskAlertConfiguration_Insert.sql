USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskAlertConfiguration_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskAlertConfiguration_Insert]
GO

CREATE PROCEDURE DBO.[TaskAlertConfiguration_Insert]
		@TaskAlertConfigurationTypeId int, 
		@TaskAlertId int, 
		@StringValue varchar(1000), 
		@IntValue int, 
		@TimeValue time, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into TaskAlertConfiguration
			(TaskAlertConfigurationTypeId, TaskAlertId, StringValue, IntValue, TimeValue, UpdateUserID, StartDt)
	VALUES
			(@TaskAlertConfigurationTypeId, @TaskAlertId, @StringValue, @IntValue, @TimeValue, @UpdateUserID, @StartDt)

	SELECT	TaskAlertConfigurationId, StartDt, DataVersion
	FROM	TaskAlertConfiguration
	WHERE	TaskAlertConfigurationId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
