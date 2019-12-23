USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientPlatform_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientPlatform_Delete]
GO

CREATE PROCEDURE DBO.[ClientPlatform_Delete]
		@ClientPlatformId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ClientPlatform_hst (
			ClientPlatformId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ClientPlatformId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ClientPlatform
	WHERE	ClientPlatformId = @ClientPlatformId

	DELETE	ClientPlatform
	WHERE	ClientPlatformId = @ClientPlatformId
	AND		DataVersion = @DataVersion
GO
