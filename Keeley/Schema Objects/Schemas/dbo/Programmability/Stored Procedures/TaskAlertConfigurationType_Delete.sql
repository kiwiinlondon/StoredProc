USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskAlertConfigurationType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskAlertConfigurationType_Delete]
GO

CREATE PROCEDURE DBO.[TaskAlertConfigurationType_Delete]
		@TaskAlertConfigurationTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO TaskAlertConfigurationType_hst (
			TaskAlertConfigurationTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	TaskAlertConfigurationTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	TaskAlertConfigurationType
	WHERE	TaskAlertConfigurationTypeId = @TaskAlertConfigurationTypeId

	DELETE	TaskAlertConfigurationType
	WHERE	TaskAlertConfigurationTypeId = @TaskAlertConfigurationTypeId
	AND		DataVersion = @DataVersion
GO
