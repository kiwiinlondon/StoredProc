USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskAlertConfiguration_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskAlertConfiguration_Update]
GO

CREATE PROCEDURE DBO.[TaskAlertConfiguration_Update]
		@TaskAlertConfigurationId int, 
		@TaskAlertConfigurationTypeId int, 
		@TaskAlertId int, 
		@StringValue varchar(1000), 
		@IntValue int, 
		@TimeValue time, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO TaskAlertConfiguration_hst (
			TaskAlertConfigurationId, TaskAlertConfigurationTypeId, TaskAlertId, StringValue, IntValue, TimeValue, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	TaskAlertConfigurationId, TaskAlertConfigurationTypeId, TaskAlertId, StringValue, IntValue, TimeValue, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	TaskAlertConfiguration
	WHERE	TaskAlertConfigurationId = @TaskAlertConfigurationId

	UPDATE	TaskAlertConfiguration
	SET		TaskAlertConfigurationTypeId = @TaskAlertConfigurationTypeId, TaskAlertId = @TaskAlertId, StringValue = @StringValue, IntValue = @IntValue, TimeValue = @TimeValue, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	TaskAlertConfigurationId = @TaskAlertConfigurationId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	TaskAlertConfiguration
	WHERE	TaskAlertConfigurationId = @TaskAlertConfigurationId
	AND		@@ROWCOUNT > 0

GO
