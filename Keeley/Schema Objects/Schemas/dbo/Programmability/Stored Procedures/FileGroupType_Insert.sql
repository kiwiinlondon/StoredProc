USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FileGroupType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FileGroupType_Insert]
GO

CREATE PROCEDURE DBO.[FileGroupType_Insert]
		@Name varchar(200), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FileGroupType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	FileGroupTypeId, StartDt, DataVersion
	FROM	FileGroupType
	WHERE	FileGroupTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
