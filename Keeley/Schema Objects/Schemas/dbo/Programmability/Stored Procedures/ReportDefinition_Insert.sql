USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ReportDefinition_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ReportDefinition_Insert]
GO

CREATE PROCEDURE DBO.[ReportDefinition_Insert]
		@JSON varchar(-1), 
		@ReportTypeId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ReportDefinition
			(JSON, ReportTypeId, UpdateUserID, StartDt)
	VALUES
			(@JSON, @ReportTypeId, @UpdateUserID, @StartDt)

	SELECT	ReportDefinitionId, StartDt, DataVersion
	FROM	ReportDefinition
	WHERE	ReportDefinitionId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
