USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskAlertConfigurationType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskAlertConfigurationType_Update]
GO

CREATE PROCEDURE DBO.[TaskAlertConfigurationType_Update]
		@TaskAlertConfigurationTypeId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO TaskAlertConfigurationType_hst (
			TaskAlertConfigurationTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	TaskAlertConfigurationTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	TaskAlertConfigurationType
	WHERE	TaskAlertConfigurationTypeId = @TaskAlertConfigurationTypeId

	UPDATE	TaskAlertConfigurationType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	TaskAlertConfigurationTypeId = @TaskAlertConfigurationTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	TaskAlertConfigurationType
	WHERE	TaskAlertConfigurationTypeId = @TaskAlertConfigurationTypeId
	AND		@@ROWCOUNT > 0

GO
