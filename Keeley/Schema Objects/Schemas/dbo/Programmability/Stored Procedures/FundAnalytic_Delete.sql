USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundAnalytic_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundAnalytic_Delete]
GO

CREATE PROCEDURE DBO.[FundAnalytic_Delete]
		@FundAnalyticId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FundAnalytic_hst (
			FundAnalyticId, FundAnalyticTypeId, FundId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, IsLast, EndDt, LastActionUserID)
	SELECT	FundAnalyticId, FundAnalyticTypeId, FundId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, IsLast, @EndDt, @UpdateUserID
	FROM	FundAnalytic
	WHERE	FundAnalyticId = @FundAnalyticId

	DELETE	FundAnalytic
	WHERE	FundAnalyticId = @FundAnalyticId
	AND		DataVersion = @DataVersion
GO
