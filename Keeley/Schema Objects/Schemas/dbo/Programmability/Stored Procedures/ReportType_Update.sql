USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ReportType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ReportType_Update]
GO

CREATE PROCEDURE DBO.[ReportType_Update]
		@ReportTypeId int, 
		@Name varchar(256), 
		@DataVersion rowversion, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ReportType_hst (
			ReportTypeId, Name, StartDt, DataVersion, UpdateUserID, EndDt, LastActionUserID)
	SELECT	ReportTypeId, Name, StartDt, DataVersion, UpdateUserID, @StartDt, @UpdateUserID
	FROM	ReportType
	WHERE	ReportTypeId = @ReportTypeId

	UPDATE	ReportType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ReportTypeId = @ReportTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ReportType
	WHERE	ReportTypeId = @ReportTypeId
	AND		@@ROWCOUNT > 0

GO
