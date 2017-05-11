USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[dba_indexDefragExclusion_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[dba_indexDefragExclusion_Insert]
GO

CREATE PROCEDURE DBO.[dba_indexDefragExclusion_Insert]
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

	INSERT into dba_indexDefragExclusion
			(databaseID, databaseName, objectID, objectName, indexID, indexName, exclusionMask, StartDt)
	VALUES
			(@databaseID, @databaseName, @objectID, @objectName, @indexID, @indexName, @exclusionMask, @StartDt)

	SELECT	indexID, StartDt, DataVersion
	FROM	dba_indexDefragExclusion
	WHERE	indexID = @indexID
	AND		@@ROWCOUNT > 0

GO
