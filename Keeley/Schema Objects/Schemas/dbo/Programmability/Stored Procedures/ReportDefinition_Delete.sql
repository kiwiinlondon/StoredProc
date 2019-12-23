USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ReportDefinition_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ReportDefinition_Delete]
GO

CREATE PROCEDURE DBO.[ReportDefinition_Delete]
		@ReportDefinitionId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ReportDefinition_hst (
			ReportDefinitionId, JSON, ReportTypeId, StartDt, DataVersion, UpdateUserID, EndDt, LastActionUserID)
	SELECT	ReportDefinitionId, JSON, ReportTypeId, StartDt, DataVersion, UpdateUserID, @EndDt, @UpdateUserID
	FROM	ReportDefinition
	WHERE	ReportDefinitionId = @ReportDefinitionId

	DELETE	ReportDefinition
	WHERE	ReportDefinitionId = @ReportDefinitionId
	AND		DataVersion = @DataVersion
GO
