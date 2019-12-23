USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ReportType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ReportType_Delete]
GO

CREATE PROCEDURE DBO.[ReportType_Delete]
		@ReportTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ReportType_hst (
			ReportTypeId, Name, StartDt, DataVersion, UpdateUserID, EndDt, LastActionUserID)
	SELECT	ReportTypeId, Name, StartDt, DataVersion, UpdateUserID, @EndDt, @UpdateUserID
	FROM	ReportType
	WHERE	ReportTypeId = @ReportTypeId

	DELETE	ReportType
	WHERE	ReportTypeId = @ReportTypeId
	AND		DataVersion = @DataVersion
GO
