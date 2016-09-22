USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[dba_indexDefragLog_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[dba_indexDefragLog_Update]
GO

CREATE PROCEDURE DBO.[dba_indexDefragLog_Update]
		@indexDefrag_id int, 
		@databaseID int, 
		@databaseName nvarchar, 
		@objectID int, 
		@objectName nvarchar, 
		@indexID int, 
		@indexName nvarchar, 
		@partitionNumber smallint, 
		@fragmentation float, 
		@page_count int, 
		@dateTimeStart datetime, 
		@dateTimeEnd datetime, 
		@durationSeconds int, 
		@sqlStatement varchar(4000), 
		@errorMessage varchar(1000)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO dba_indexDefragLog_hst (
			indexDefrag_id, databaseID, databaseName, objectID, objectName, indexID, indexName, partitionNumber, fragmentation, page_count, dateTimeStart, dateTimeEnd, durationSeconds, sqlStatement, errorMessage, EndDt, LastActionUserID)
	SELECT	indexDefrag_id, databaseID, databaseName, objectID, objectName, indexID, indexName, partitionNumber, fragmentation, page_count, dateTimeStart, dateTimeEnd, durationSeconds, sqlStatement, errorMessage, @StartDt, @UpdateUserID
	FROM	dba_indexDefragLog
	WHERE	indexDefrag_id = @indexDefrag_id

	UPDATE	dba_indexDefragLog
	SET		databaseID = @databaseID, databaseName = @databaseName, objectID = @objectID, objectName = @objectName, indexID = @indexID, indexName = @indexName, partitionNumber = @partitionNumber, fragmentation = @fragmentation, page_count = @page_count, dateTimeStart = @dateTimeStart, dateTimeEnd = @dateTimeEnd, durationSeconds = @durationSeconds, sqlStatement = @sqlStatement, errorMessage = @errorMessage,  StartDt = @StartDt
	WHERE	indexDefrag_id = @indexDefrag_id
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	dba_indexDefragLog
	WHERE	indexDefrag_id = @indexDefrag_id
	AND		@@ROWCOUNT > 0

GO
