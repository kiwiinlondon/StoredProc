USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ReportBaseline_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ReportBaseline_Update]
GO

CREATE PROCEDURE DBO.[ReportBaseline_Update]
		@ReportBaselineId int, 
		@Name varchar(250), 
		@FundIds varchar(250), 
		@JSON varchar(-1), 
		@GenerateEndOfLastYear bit, 
		@GenerateEndOfLastMonth bit, 
		@DataVersion rowversion, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ReportBaseline_hst (
			ReportBaselineId, Name, FundIds, JSON, GenerateEndOfLastYear, GenerateEndOfLastMonth, StartDt, DataVersion, UpdateUserID, EndDt, LastActionUserID)
	SELECT	ReportBaselineId, Name, FundIds, JSON, GenerateEndOfLastYear, GenerateEndOfLastMonth, StartDt, DataVersion, UpdateUserID, @StartDt, @UpdateUserID
	FROM	ReportBaseline
	WHERE	ReportBaselineId = @ReportBaselineId

	UPDATE	ReportBaseline
	SET		Name = @Name, FundIds = @FundIds, JSON = @JSON, GenerateEndOfLastYear = @GenerateEndOfLastYear, GenerateEndOfLastMonth = @GenerateEndOfLastMonth, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ReportBaselineId = @ReportBaselineId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ReportBaseline
	WHERE	ReportBaselineId = @ReportBaselineId
	AND		@@ROWCOUNT > 0

GO
