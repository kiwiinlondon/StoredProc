USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[dba_indexDefragExclusion_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[dba_indexDefragExclusion_Update]
GO

CREATE PROCEDURE DBO.[dba_indexDefragExclusion_Update]
		@databaseID int, 
		@databaseName nvarchar, 
		@objectID int, 
		@objectName nvarchar, 
		@indexID int, 
		@indexName nvarchar, 
		@exclusionMask int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO dba_indexDefragExclusion_hst (
			databaseID, databaseName, objectID, objectName, indexID, indexName, exclusionMask, EndDt, LastActionUserID)
	SELECT	databaseID, databaseName, objectID, objectName, indexID, indexName, exclusionMask, @StartDt, @UpdateUserID
	FROM	dba_indexDefragExclusion
	WHERE	indexID = @indexID

	UPDATE	dba_indexDefragExclusion
	SET		databaseName = @databaseName, objectName = @objectName, indexName = @indexName, exclusionMask = @exclusionMask,  StartDt = @StartDt
	WHERE	indexID = @indexID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	dba_indexDefragExclusion
	WHERE	indexID = @indexID
	AND		@@ROWCOUNT > 0

GO
