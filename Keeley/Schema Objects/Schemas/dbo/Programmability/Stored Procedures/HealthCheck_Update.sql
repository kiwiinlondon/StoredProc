USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[HealthCheck_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[HealthCheck_Update]
GO

CREATE PROCEDURE DBO.[HealthCheck_Update]
		@HealthCheckId int, 
		@HealthCheckTypeId int, 
		@Name varchar(100), 
		@ErrorInProgress bit, 
		@LastCheckTime datetime, 
		@EmailFrequencyMins int, 
		@Arguments varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@ErrorEmailSendTime datetime
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO HealthCheck_hst (
			HealthCheckId, HealthCheckTypeId, Name, ErrorInProgress, LastCheckTime, EmailFrequencyMins, Arguments, StartDt, UpdateUserID, DataVersion, ErrorEmailSendTime, EndDt, LastActionUserID)
	SELECT	HealthCheckId, HealthCheckTypeId, Name, ErrorInProgress, LastCheckTime, EmailFrequencyMins, Arguments, StartDt, UpdateUserID, DataVersion, ErrorEmailSendTime, @StartDt, @UpdateUserID
	FROM	HealthCheck
	WHERE	HealthCheckId = @HealthCheckId

	UPDATE	HealthCheck
	SET		HealthCheckTypeId = @HealthCheckTypeId, Name = @Name, ErrorInProgress = @ErrorInProgress, LastCheckTime = @LastCheckTime, EmailFrequencyMins = @EmailFrequencyMins, Arguments = @Arguments, UpdateUserID = @UpdateUserID, ErrorEmailSendTime = @ErrorEmailSendTime,  StartDt = @StartDt
	WHERE	HealthCheckId = @HealthCheckId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	HealthCheck
	WHERE	HealthCheckId = @HealthCheckId
	AND		@@ROWCOUNT > 0

GO
