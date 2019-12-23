USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FileNameResolutionType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FileNameResolutionType_Insert]
GO

CREATE PROCEDURE DBO.[FileNameResolutionType_Insert]
		@Name varchar(70), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FileNameResolutionType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	FileNameResolutionTypeId, StartDt, DataVersion
	FROM	FileNameResolutionType
	WHERE	FileNameResolutionTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
