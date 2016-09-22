USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[dba_indexDefragStatus_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[dba_indexDefragStatus_Update]
GO

CREATE PROCEDURE DBO.[dba_indexDefragStatus_Update]
		@databaseID int, 
		@databaseName nvarchar, 
		@objectID int, 
		@indexID int, 
		@partitionNumber smallint, 
		@fragmentation float, 
		@page_count int, 
		@range_scan_count bigint, 
		@schemaName nvarchar, 
		@objectName nvarchar, 
		@indexName nvarchar, 
		@scanDate datetime, 
		@defragDate datetime, 
		@printStatus bit, 
		@exclusionMask int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO dba_indexDefragStatus_hst (
			databaseID, databaseName, objectID, indexID, partitionNumber, fragmentation, page_count, range_scan_count, schemaName, objectName, indexName, scanDate, defragDate, printStatus, exclusionMask, EndDt, LastActionUserID)
	SELECT	databaseID, databaseName, objectID, indexID, partitionNumber, fragmentation, page_count, range_scan_count, schemaName, objectName, indexName, scanDate, defragDate, printStatus, exclusionMask, @StartDt, @UpdateUserID
	FROM	dba_indexDefragStatus
	WHERE	partitionNumber = @partitionNumber

	UPDATE	dba_indexDefragStatus
	SET		databaseName = @databaseName, fragmentation = @fragmentation, page_count = @page_count, range_scan_count = @range_scan_count, schemaName = @schemaName, objectName = @objectName, indexName = @indexName, scanDate = @scanDate, defragDate = @defragDate, printStatus = @printStatus, exclusionMask = @exclusionMask,  StartDt = @StartDt
	WHERE	partitionNumber = @partitionNumber
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	dba_indexDefragStatus
	WHERE	partitionNumber = @partitionNumber
	AND		@@ROWCOUNT > 0

GO
