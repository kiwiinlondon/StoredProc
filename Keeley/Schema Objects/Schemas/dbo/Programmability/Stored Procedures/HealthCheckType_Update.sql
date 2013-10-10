USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[HealthCheckType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[HealthCheckType_Update]
GO

CREATE PROCEDURE DBO.[HealthCheckType_Update]
		@HealthCheckTypeId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO HealthCheckType_hst (
			HealthCheckTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	HealthCheckTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	HealthCheckType
	WHERE	HealthCheckTypeId = @HealthCheckTypeId

	UPDATE	HealthCheckType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	HealthCheckTypeId = @HealthCheckTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	HealthCheckType
	WHERE	HealthCheckTypeId = @HealthCheckTypeId
	AND		@@ROWCOUNT > 0

GO
