USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IntranetReport_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IntranetReport_Delete]
GO

CREATE PROCEDURE DBO.[IntranetReport_Delete]
		@IntranetReportId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO IntranetReport_hst (
			IntranetReportId, Name, Path, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	IntranetReportId, Name, Path, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	IntranetReport
	WHERE	IntranetReportId = @IntranetReportId

	DELETE	IntranetReport
	WHERE	IntranetReportId = @IntranetReportId
	AND		DataVersion = @DataVersion
GO
