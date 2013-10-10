USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[HealthCheck_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[HealthCheck_Insert]
GO

CREATE PROCEDURE DBO.[HealthCheck_Insert]
		@HealthCheckTypeId int, 
		@Name varchar(100), 
		@ErrorInProgress bit, 
		@LastCheckTime datetime, 
		@EmailFrequencyMins int, 
		@Arguments varchar(100), 
		@UpdateUserID int, 
		@ErrorEmailSendTime datetime
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into HealthCheck
			(HealthCheckTypeId, Name, ErrorInProgress, LastCheckTime, EmailFrequencyMins, Arguments, UpdateUserID, ErrorEmailSendTime, StartDt)
	VALUES
			(@HealthCheckTypeId, @Name, @ErrorInProgress, @LastCheckTime, @EmailFrequencyMins, @Arguments, @UpdateUserID, @ErrorEmailSendTime, @StartDt)

	SELECT	HealthCheckId, StartDt, DataVersion
	FROM	HealthCheck
	WHERE	HealthCheckId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
