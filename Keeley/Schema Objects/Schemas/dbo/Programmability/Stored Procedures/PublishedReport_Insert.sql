USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PublishedReport_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PublishedReport_Insert]
GO

CREATE PROCEDURE DBO.[PublishedReport_Insert]
		@ReportGuid varchar(250), 
		@ReportName varchar(250), 
		@FundIds varchar(250), 
		@RelativeDateId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PublishedReport
			(ReportGuid, ReportName, FundIds, RelativeDateId, UpdateUserID, StartDt)
	VALUES
			(@ReportGuid, @ReportName, @FundIds, @RelativeDateId, @UpdateUserID, @StartDt)

	SELECT	PublishedReportId, StartDt, DataVersion
	FROM	PublishedReport
	WHERE	PublishedReportId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
