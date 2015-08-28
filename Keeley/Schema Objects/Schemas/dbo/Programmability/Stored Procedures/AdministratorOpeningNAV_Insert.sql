USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AdministratorOpeningNAV_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AdministratorOpeningNAV_Insert]
GO

CREATE PROCEDURE DBO.[AdministratorOpeningNAV_Insert]
		@FundId int, 
		@ReferenceDate datetime, 
		@Value numeric(27,8), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into AdministratorOpeningNAV
			(FundId, ReferenceDate, Value, UpdateUserID, StartDt)
	VALUES
			(@FundId, @ReferenceDate, @Value, @UpdateUserID, @StartDt)

	SELECT	AdministratorOpeningValueID, StartDt, DataVersion
	FROM	AdministratorOpeningNAV
	WHERE	AdministratorOpeningValueID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
