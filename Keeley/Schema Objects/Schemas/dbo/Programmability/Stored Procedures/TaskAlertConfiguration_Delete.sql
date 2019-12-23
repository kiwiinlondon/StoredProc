USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskAlertConfiguration_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskAlertConfiguration_Delete]
GO

CREATE PROCEDURE DBO.[TaskAlertConfiguration_Delete]
		@TaskAlertConfigurationId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO TaskAlertConfiguration_hst (
			TaskAlertConfigurationId, TaskAlertConfigurationTypeId, TaskAlertId, StringValue, IntValue, TimeValue, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	TaskAlertConfigurationId, TaskAlertConfigurationTypeId, TaskAlertId, StringValue, IntValue, TimeValue, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	TaskAlertConfiguration
	WHERE	TaskAlertConfigurationId = @TaskAlertConfigurationId

	DELETE	TaskAlertConfiguration
	WHERE	TaskAlertConfigurationId = @TaskAlertConfigurationId
	AND		DataVersion = @DataVersion
GO
