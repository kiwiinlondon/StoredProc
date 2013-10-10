USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[HealthCheck_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[HealthCheck_Delete]
GO

CREATE PROCEDURE DBO.[HealthCheck_Delete]
		@HealthCheckId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO HealthCheck_hst (
			HealthCheckId, HealthCheckTypeId, Name, ErrorInProgress, LastCheckTime, EmailFrequencyMins, Arguments, StartDt, UpdateUserID, DataVersion, ErrorEmailSendTime, EndDt, LastActionUserID)
	SELECT	HealthCheckId, HealthCheckTypeId, Name, ErrorInProgress, LastCheckTime, EmailFrequencyMins, Arguments, StartDt, UpdateUserID, DataVersion, ErrorEmailSendTime, @EndDt, @UpdateUserID
	FROM	HealthCheck
	WHERE	HealthCheckId = @HealthCheckId

	DELETE	HealthCheck
	WHERE	HealthCheckId = @HealthCheckId
	AND		DataVersion = @DataVersion
GO
