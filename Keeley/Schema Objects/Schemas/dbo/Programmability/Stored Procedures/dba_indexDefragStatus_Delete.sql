USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[dba_indexDefragStatus_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[dba_indexDefragStatus_Delete]
GO

CREATE PROCEDURE DBO.[dba_indexDefragStatus_Delete]
		@partitionNumber smallint,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO dba_indexDefragStatus_hst (
			databaseID, databaseName, objectID, indexID, partitionNumber, fragmentation, page_count, range_scan_count, schemaName, objectName, indexName, scanDate, defragDate, printStatus, exclusionMask, EndDt, LastActionUserID)
	SELECT	databaseID, databaseName, objectID, indexID, partitionNumber, fragmentation, page_count, range_scan_count, schemaName, objectName, indexName, scanDate, defragDate, printStatus, exclusionMask, @EndDt, @UpdateUserID
	FROM	dba_indexDefragStatus
	WHERE	partitionNumber = @partitionNumber

	DELETE	dba_indexDefragStatus
	WHERE	partitionNumber = @partitionNumber
	AND		DataVersion = @DataVersion
GO
