USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundManagerAnalytic_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundManagerAnalytic_Insert]
GO

CREATE PROCEDURE DBO.[FundManagerAnalytic_Insert]
		@FundAnalyticTypeId int, 
		@FundManagerId int, 
		@ReferenceDate datetime, 
		@Value numeric(27,8), 
		@UpdateUserID int, 
		@IsLast bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FundManagerAnalytic
			(FundAnalyticTypeId, FundManagerId, ReferenceDate, Value, UpdateUserID, IsLast, StartDt)
	VALUES
			(@FundAnalyticTypeId, @FundManagerId, @ReferenceDate, @Value, @UpdateUserID, @IsLast, @StartDt)

	SELECT	FundManagerAnalyticId, StartDt, DataVersion
	FROM	FundManagerAnalytic
	WHERE	FundManagerAnalyticId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
