USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ReportKeyType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ReportKeyType_Update]
GO

CREATE PROCEDURE DBO.[ReportKeyType_Update]
		@ReportKeyTypeId int, 
		@Name varchar(256), 
		@DataVersion rowversion, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ReportKeyType_hst (
			ReportKeyTypeId, Name, StartDt, DataVersion, UpdateUserID, EndDt, LastActionUserID)
	SELECT	ReportKeyTypeId, Name, StartDt, DataVersion, UpdateUserID, @StartDt, @UpdateUserID
	FROM	ReportKeyType
	WHERE	ReportKeyTypeId = @ReportKeyTypeId

	UPDATE	ReportKeyType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ReportKeyTypeId = @ReportKeyTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ReportKeyType
	WHERE	ReportKeyTypeId = @ReportKeyTypeId
	AND		@@ROWCOUNT > 0

GO
