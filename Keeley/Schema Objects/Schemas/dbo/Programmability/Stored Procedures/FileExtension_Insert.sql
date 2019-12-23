USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FileExtension_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FileExtension_Insert]
GO

CREATE PROCEDURE DBO.[FileExtension_Insert]
		@Name varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FileExtension
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	FileExtensionTypeId, StartDt, DataVersion
	FROM	FileExtension
	WHERE	FileExtensionTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
