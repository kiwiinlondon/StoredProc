USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FileType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FileType_Insert]
GO

CREATE PROCEDURE DBO.[FileType_Insert]
		@Name varchar(70), 
		@UpdateUserID int, 
		@EnableManualFileUpload bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FileType
			(Name, UpdateUserID, EnableManualFileUpload, StartDt)
	VALUES
			(@Name, @UpdateUserID, @EnableManualFileUpload, @StartDt)

	SELECT	FileTypeId, StartDt, DataVersion
	FROM	FileType
	WHERE	FileTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
