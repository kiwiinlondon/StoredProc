USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[HealthCheckType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[HealthCheckType_Delete]
GO

CREATE PROCEDURE DBO.[HealthCheckType_Delete]
		@HealthCheckTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO HealthCheckType_hst (
			HealthCheckTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	HealthCheckTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	HealthCheckType
	WHERE	HealthCheckTypeId = @HealthCheckTypeId

	DELETE	HealthCheckType
	WHERE	HealthCheckTypeId = @HealthCheckTypeId
	AND		DataVersion = @DataVersion
GO
