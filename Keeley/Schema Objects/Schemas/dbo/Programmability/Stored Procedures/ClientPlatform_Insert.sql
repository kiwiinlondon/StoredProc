USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientPlatform_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientPlatform_Insert]
GO

CREATE PROCEDURE DBO.[ClientPlatform_Insert]
		@Name varchar(150), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ClientPlatform
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	ClientPlatformId, StartDt, DataVersion
	FROM	ClientPlatform
	WHERE	ClientPlatformId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
