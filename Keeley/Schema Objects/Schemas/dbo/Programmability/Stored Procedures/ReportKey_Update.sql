USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ReportKey_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ReportKey_Update]
GO

CREATE PROCEDURE DBO.[ReportKey_Update]
		@ReportKeyId int, 
		@HashKey varchar(-1), 
		@ReportKeyTypeId int, 
		@ReportDefinitionId int, 
		@DataVersion rowversion, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ReportKey_hst (
			ReportKeyId, HashKey, ReportKeyTypeId, ReportDefinitionId, StartDt, DataVersion, UpdateUserID, EndDt, LastActionUserID)
	SELECT	ReportKeyId, HashKey, ReportKeyTypeId, ReportDefinitionId, StartDt, DataVersion, UpdateUserID, @StartDt, @UpdateUserID
	FROM	ReportKey
	WHERE	ReportKeyId = @ReportKeyId

	UPDATE	ReportKey
	SET		HashKey = @HashKey, ReportKeyTypeId = @ReportKeyTypeId, ReportDefinitionId = @ReportDefinitionId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ReportKeyId = @ReportKeyId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ReportKey
	WHERE	ReportKeyId = @ReportKeyId
	AND		@@ROWCOUNT > 0

GO
