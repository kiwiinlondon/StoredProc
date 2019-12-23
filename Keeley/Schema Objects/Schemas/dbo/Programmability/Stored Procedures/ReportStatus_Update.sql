USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ReportStatus_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ReportStatus_Update]
GO

CREATE PROCEDURE DBO.[ReportStatus_Update]
		@ReportStatusId int, 
		@Name varchar(50), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ReportStatus_hst (
			ReportStatusId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ReportStatusId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ReportStatus
	WHERE	 = @

	UPDATE	ReportStatus
	SET		ReportStatusId = @ReportStatusId, Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	 = @
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ReportStatus
	WHERE	 = @
	AND		@@ROWCOUNT > 0

GO
