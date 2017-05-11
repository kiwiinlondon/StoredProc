USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[dba_indexDefragExclusion_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[dba_indexDefragExclusion_Delete]
GO

CREATE PROCEDURE DBO.[dba_indexDefragExclusion_Delete]
		@indexID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO dba_indexDefragExclusion_hst (
			databaseID, databaseName, objectID, objectName, indexID, indexName, exclusionMask, EndDt, LastActionUserID)
	SELECT	databaseID, databaseName, objectID, objectName, indexID, indexName, exclusionMask, @EndDt, @UpdateUserID
	FROM	dba_indexDefragExclusion
	WHERE	indexID = @indexID

	DELETE	dba_indexDefragExclusion
	WHERE	indexID = @indexID
	AND		DataVersion = @DataVersion
GO
