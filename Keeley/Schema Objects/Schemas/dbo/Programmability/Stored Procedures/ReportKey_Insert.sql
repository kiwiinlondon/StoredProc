USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ReportKey_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ReportKey_Insert]
GO

CREATE PROCEDURE DBO.[ReportKey_Insert]
		@HashKey varchar(-1), 
		@ReportKeyTypeId int, 
		@ReportDefinitionId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ReportKey
			(HashKey, ReportKeyTypeId, ReportDefinitionId, UpdateUserID, StartDt)
	VALUES
			(@HashKey, @ReportKeyTypeId, @ReportDefinitionId, @UpdateUserID, @StartDt)

	SELECT	ReportKeyId, StartDt, DataVersion
	FROM	ReportKey
	WHERE	ReportKeyId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
