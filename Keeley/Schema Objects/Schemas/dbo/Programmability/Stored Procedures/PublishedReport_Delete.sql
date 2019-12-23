USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PublishedReport_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PublishedReport_Delete]
GO

CREATE PROCEDURE DBO.[PublishedReport_Delete]
		@PublishedReportId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PublishedReport_hst (
			PublishedReportId, ReportGuid, ReportName, FundIds, RelativeDateId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PublishedReportId, ReportGuid, ReportName, FundIds, RelativeDateId, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	PublishedReport
	WHERE	PublishedReportId = @PublishedReportId

	DELETE	PublishedReport
	WHERE	PublishedReportId = @PublishedReportId
	AND		DataVersion = @DataVersion
GO
