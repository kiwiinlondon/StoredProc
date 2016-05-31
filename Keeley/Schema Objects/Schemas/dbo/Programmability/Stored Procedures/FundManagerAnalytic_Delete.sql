USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundManagerAnalytic_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundManagerAnalytic_Delete]
GO

CREATE PROCEDURE DBO.[FundManagerAnalytic_Delete]
		@FundManagerAnalyticId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FundManagerAnalytic_hst (
			FundManagerAnalyticId, FundAnalyticTypeId, FundManagerId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, IsLast, EndDt, LastActionUserID)
	SELECT	FundManagerAnalyticId, FundAnalyticTypeId, FundManagerId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, IsLast, @EndDt, @UpdateUserID
	FROM	FundManagerAnalytic
	WHERE	FundManagerAnalyticId = @FundManagerAnalyticId

	DELETE	FundManagerAnalytic
	WHERE	FundManagerAnalyticId = @FundManagerAnalyticId
	AND		DataVersion = @DataVersion
GO
