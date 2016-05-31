USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundAnalytic_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundAnalytic_Update]
GO

CREATE PROCEDURE DBO.[FundAnalytic_Update]
		@FundAnalyticId int, 
		@FundAnalyticTypeId int, 
		@FundId int, 
		@ReferenceDate datetime, 
		@Value numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@IsLast bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FundAnalytic_hst (
			FundAnalyticId, FundAnalyticTypeId, FundId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, IsLast, EndDt, LastActionUserID)
	SELECT	FundAnalyticId, FundAnalyticTypeId, FundId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, IsLast, @StartDt, @UpdateUserID
	FROM	FundAnalytic
	WHERE	FundAnalyticId = @FundAnalyticId

	UPDATE	FundAnalytic
	SET		FundAnalyticTypeId = @FundAnalyticTypeId, FundId = @FundId, ReferenceDate = @ReferenceDate, Value = @Value, UpdateUserID = @UpdateUserID, IsLast = @IsLast,  StartDt = @StartDt
	WHERE	FundAnalyticId = @FundAnalyticId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FundAnalytic
	WHERE	FundAnalyticId = @FundAnalyticId
	AND		@@ROWCOUNT > 0

GO
