USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PublishedReport_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PublishedReport_Update]
GO

CREATE PROCEDURE DBO.[PublishedReport_Update]
		@PublishedReportId int, 
		@ReportGuid varchar(250), 
		@ReportName varchar(250), 
		@FundIds varchar(250), 
		@RelativeDateId int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PublishedReport_hst (
			PublishedReportId, ReportGuid, ReportName, FundIds, RelativeDateId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PublishedReportId, ReportGuid, ReportName, FundIds, RelativeDateId, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	PublishedReport
	WHERE	PublishedReportId = @PublishedReportId

	UPDATE	PublishedReport
	SET		ReportGuid = @ReportGuid, ReportName = @ReportName, FundIds = @FundIds, RelativeDateId = @RelativeDateId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	PublishedReportId = @PublishedReportId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PublishedReport
	WHERE	PublishedReportId = @PublishedReportId
	AND		@@ROWCOUNT > 0

GO
