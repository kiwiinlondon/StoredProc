USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ReportBaseline_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ReportBaseline_Insert]
GO

CREATE PROCEDURE DBO.[ReportBaseline_Insert]
		@Name varchar(250), 
		@FundIds varchar(250), 
		@JSON varchar(-1), 
		@GenerateEndOfLastYear bit, 
		@GenerateEndOfLastMonth bit, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ReportBaseline
			(Name, FundIds, JSON, GenerateEndOfLastYear, GenerateEndOfLastMonth, UpdateUserID, StartDt)
	VALUES
			(@Name, @FundIds, @JSON, @GenerateEndOfLastYear, @GenerateEndOfLastMonth, @UpdateUserID, @StartDt)

	SELECT	ReportBaselineId, StartDt, DataVersion
	FROM	ReportBaseline
	WHERE	ReportBaselineId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
