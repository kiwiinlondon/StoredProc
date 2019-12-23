USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ReportKey_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ReportKey_Delete]
GO

CREATE PROCEDURE DBO.[ReportKey_Delete]
		@ReportKeyId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ReportKey_hst (
			ReportKeyId, HashKey, ReportKeyTypeId, ReportDefinitionId, StartDt, DataVersion, UpdateUserID, EndDt, LastActionUserID)
	SELECT	ReportKeyId, HashKey, ReportKeyTypeId, ReportDefinitionId, StartDt, DataVersion, UpdateUserID, @EndDt, @UpdateUserID
	FROM	ReportKey
	WHERE	ReportKeyId = @ReportKeyId

	DELETE	ReportKey
	WHERE	ReportKeyId = @ReportKeyId
	AND		DataVersion = @DataVersion
GO
