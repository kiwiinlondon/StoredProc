USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[HealthCheckType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[HealthCheckType_Insert]
GO

CREATE PROCEDURE DBO.[HealthCheckType_Insert]
		@Name varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into HealthCheckType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	HealthCheckTypeId, StartDt, DataVersion
	FROM	HealthCheckType
	WHERE	HealthCheckTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
