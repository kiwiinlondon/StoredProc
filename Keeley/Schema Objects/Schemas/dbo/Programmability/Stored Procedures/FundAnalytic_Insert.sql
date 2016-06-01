USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundAnalytic_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundAnalytic_Insert]
GO

CREATE PROCEDURE DBO.[FundAnalytic_Insert]
		@FundAnalyticTypeId int, 
		@FundId int, 
		@ReferenceDate datetime, 
		@Value numeric(27,8), 
		@CurrencyId int, 
		@UpdateUserID int, 
		@IsLast bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FundAnalytic
			(FundAnalyticTypeId, FundId, ReferenceDate, Value, CurrencyId, UpdateUserID, IsLast, StartDt)
	VALUES
			(@FundAnalyticTypeId, @FundId, @ReferenceDate, @Value, @CurrencyId, @UpdateUserID, @IsLast, @StartDt)

	SELECT	FundAnalyticId, StartDt, DataVersion
	FROM	FundAnalytic
	WHERE	FundAnalyticId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
