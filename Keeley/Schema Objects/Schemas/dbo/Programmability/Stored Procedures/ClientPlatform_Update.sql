USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientPlatform_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientPlatform_Update]
GO

CREATE PROCEDURE DBO.[ClientPlatform_Update]
		@ClientPlatformId int, 
		@Name varchar(150), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ClientPlatform_hst (
			ClientPlatformId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ClientPlatformId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ClientPlatform
	WHERE	ClientPlatformId = @ClientPlatformId

	UPDATE	ClientPlatform
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ClientPlatformId = @ClientPlatformId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ClientPlatform
	WHERE	ClientPlatformId = @ClientPlatformId
	AND		@@ROWCOUNT > 0

GO
