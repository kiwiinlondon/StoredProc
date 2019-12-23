USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ReportKeyType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ReportKeyType_Delete]
GO

CREATE PROCEDURE DBO.[ReportKeyType_Delete]
		@ReportKeyTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ReportKeyType_hst (
			ReportKeyTypeId, Name, StartDt, DataVersion, UpdateUserID, EndDt, LastActionUserID)
	SELECT	ReportKeyTypeId, Name, StartDt, DataVersion, UpdateUserID, @EndDt, @UpdateUserID
	FROM	ReportKeyType
	WHERE	ReportKeyTypeId = @ReportKeyTypeId

	DELETE	ReportKeyType
	WHERE	ReportKeyTypeId = @ReportKeyTypeId
	AND		DataVersion = @DataVersion
GO
