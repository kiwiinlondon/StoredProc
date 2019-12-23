USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ReportDefinition_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ReportDefinition_Update]
GO

CREATE PROCEDURE DBO.[ReportDefinition_Update]
		@ReportDefinitionId int, 
		@JSON varchar(-1), 
		@ReportTypeId int, 
		@DataVersion rowversion, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ReportDefinition_hst (
			ReportDefinitionId, JSON, ReportTypeId, StartDt, DataVersion, UpdateUserID, EndDt, LastActionUserID)
	SELECT	ReportDefinitionId, JSON, ReportTypeId, StartDt, DataVersion, UpdateUserID, @StartDt, @UpdateUserID
	FROM	ReportDefinition
	WHERE	ReportDefinitionId = @ReportDefinitionId

	UPDATE	ReportDefinition
	SET		JSON = @JSON, ReportTypeId = @ReportTypeId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ReportDefinitionId = @ReportDefinitionId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ReportDefinition
	WHERE	ReportDefinitionId = @ReportDefinitionId
	AND		@@ROWCOUNT > 0

GO
