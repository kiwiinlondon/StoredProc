USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FileProcessingMethod_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FileProcessingMethod_Insert]
GO

CREATE PROCEDURE DBO.[FileProcessingMethod_Insert]
		@Name varchar(70), 
		@FileTypeId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FileProcessingMethod
			(Name, FileTypeId, UpdateUserID, StartDt)
	VALUES
			(@Name, @FileTypeId, @UpdateUserID, @StartDt)

	SELECT	FileProcessingMethodId, StartDt, DataVersion
	FROM	FileProcessingMethod
	WHERE	FileProcessingMethodId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
