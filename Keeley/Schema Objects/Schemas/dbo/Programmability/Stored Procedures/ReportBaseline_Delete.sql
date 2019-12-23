USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ReportBaseline_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ReportBaseline_Delete]
GO

CREATE PROCEDURE DBO.[ReportBaseline_Delete]
		@ReportBaselineId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ReportBaseline_hst (
			ReportBaselineId, Name, FundIds, JSON, GenerateEndOfLastYear, GenerateEndOfLastMonth, StartDt, DataVersion, UpdateUserID, EndDt, LastActionUserID)
	SELECT	ReportBaselineId, Name, FundIds, JSON, GenerateEndOfLastYear, GenerateEndOfLastMonth, StartDt, DataVersion, UpdateUserID, @EndDt, @UpdateUserID
	FROM	ReportBaseline
	WHERE	ReportBaselineId = @ReportBaselineId

	DELETE	ReportBaseline
	WHERE	ReportBaselineId = @ReportBaselineId
	AND		DataVersion = @DataVersion
GO
