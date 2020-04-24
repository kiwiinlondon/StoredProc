USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IntranetReport_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IntranetReport_Update]
GO

CREATE PROCEDURE DBO.[IntranetReport_Update]
		@IntranetReportId int, 
		@Name varchar(100), 
		@Path varchar(300), 
		@Folder varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO IntranetReport_hst (
			IntranetReportId, Name, Path, Folder, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	IntranetReportId, Name, Path, Folder, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	IntranetReport
	WHERE	IntranetReportId = @IntranetReportId

	UPDATE	IntranetReport
	SET		Name = @Name, Path = @Path, Folder = @Folder, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	IntranetReportId = @IntranetReportId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	IntranetReport
	WHERE	IntranetReportId = @IntranetReportId
	AND		@@ROWCOUNT > 0

GO
