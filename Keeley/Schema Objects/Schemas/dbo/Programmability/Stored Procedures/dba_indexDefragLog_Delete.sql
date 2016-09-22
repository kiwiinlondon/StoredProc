USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[dba_indexDefragLog_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[dba_indexDefragLog_Delete]
GO

CREATE PROCEDURE DBO.[dba_indexDefragLog_Delete]
		@indexDefrag_id int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO dba_indexDefragLog_hst (
			indexDefrag_id, databaseID, databaseName, objectID, objectName, indexID, indexName, partitionNumber, fragmentation, page_count, dateTimeStart, dateTimeEnd, durationSeconds, sqlStatement, errorMessage, EndDt, LastActionUserID)
	SELECT	indexDefrag_id, databaseID, databaseName, objectID, objectName, indexID, indexName, partitionNumber, fragmentation, page_count, dateTimeStart, dateTimeEnd, durationSeconds, sqlStatement, errorMessage, @EndDt, @UpdateUserID
	FROM	dba_indexDefragLog
	WHERE	indexDefrag_id = @indexDefrag_id

	DELETE	dba_indexDefragLog
	WHERE	indexDefrag_id = @indexDefrag_id
	AND		DataVersion = @DataVersion
GO
