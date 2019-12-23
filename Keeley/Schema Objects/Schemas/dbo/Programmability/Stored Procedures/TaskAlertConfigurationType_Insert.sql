USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskAlertConfigurationType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskAlertConfigurationType_Insert]
GO

CREATE PROCEDURE DBO.[TaskAlertConfigurationType_Insert]
		@Name varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into TaskAlertConfigurationType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	TaskAlertConfigurationTypeId, StartDt, DataVersion
	FROM	TaskAlertConfigurationType
	WHERE	TaskAlertConfigurationTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
