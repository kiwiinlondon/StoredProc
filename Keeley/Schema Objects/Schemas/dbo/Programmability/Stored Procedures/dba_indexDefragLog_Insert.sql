USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[dba_indexDefragLog_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[dba_indexDefragLog_Insert]
GO

CREATE PROCEDURE DBO.[dba_indexDefragLog_Insert]
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

	INSERT into dba_indexDefragLog
			(databaseID, databaseName, objectID, objectName, indexID, indexName, partitionNumber, fragmentation, page_count, dateTimeStart, dateTimeEnd, durationSeconds, sqlStatement, errorMessage, StartDt)
	VALUES
			(@databaseID, @databaseName, @objectID, @objectName, @indexID, @indexName, @partitionNumber, @fragmentation, @page_count, @dateTimeStart, @dateTimeEnd, @durationSeconds, @sqlStatement, @errorMessage, @StartDt)

	SELECT	indexDefrag_id, StartDt, DataVersion
	FROM	dba_indexDefragLog
	WHERE	indexDefrag_id = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
