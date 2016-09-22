USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[dba_indexDefragStatus_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[dba_indexDefragStatus_Insert]
GO

CREATE PROCEDURE DBO.[dba_indexDefragStatus_Insert]
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

	INSERT into dba_indexDefragStatus
			(databaseID, databaseName, objectID, indexID, partitionNumber, fragmentation, page_count, range_scan_count, schemaName, objectName, indexName, scanDate, defragDate, printStatus, exclusionMask, StartDt)
	VALUES
			(@databaseID, @databaseName, @objectID, @indexID, @partitionNumber, @fragmentation, @page_count, @range_scan_count, @schemaName, @objectName, @indexName, @scanDate, @defragDate, @printStatus, @exclusionMask, @StartDt)

	SELECT	partitionNumber, StartDt, DataVersion
	FROM	dba_indexDefragStatus
	WHERE	partitionNumber = @partitionNumber
	AND		@@ROWCOUNT > 0

GO
