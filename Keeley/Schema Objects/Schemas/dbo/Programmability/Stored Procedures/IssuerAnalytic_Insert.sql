USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IssuerAnalytic_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IssuerAnalytic_Insert]
GO

CREATE PROCEDURE DBO.[IssuerAnalytic_Insert]
		@AnalyticTypeID int, 
		@IssuerId int, 
		@ReferenceDate datetime, 
		@Value numeric(27,8), 
		@UpdateUserID int, 
		@RawIssuerAnalyticId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into IssuerAnalytic
			(AnalyticTypeID, IssuerId, ReferenceDate, Value, UpdateUserID, RawIssuerAnalyticId, StartDt)
	VALUES
			(@AnalyticTypeID, @IssuerId, @ReferenceDate, @Value, @UpdateUserID, @RawIssuerAnalyticId, @StartDt)

	SELECT	IssuerAnalyticId, StartDt, DataVersion
	FROM	IssuerAnalytic
	WHERE	IssuerAnalyticId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
