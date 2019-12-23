USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FileCollectionType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FileCollectionType_Insert]
GO

CREATE PROCEDURE DBO.[FileCollectionType_Insert]
		@Name varchar(70), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FileCollectionType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	FileCollectionTypeId, StartDt, DataVersion
	FROM	FileCollectionType
	WHERE	FileCollectionTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
