USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundClientPlatform_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundClientPlatform_Update]
GO

CREATE PROCEDURE DBO.[FundClientPlatform_Update]
		@FundClientPlatformId int, 
		@FundId int, 
		@ClientPlatformId int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FundClientPlatform_hst (
			FundClientPlatformId, FundId, ClientPlatformId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FundClientPlatformId, FundId, ClientPlatformId, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	FundClientPlatform
	WHERE	FundClientPlatformId = @FundClientPlatformId

	UPDATE	FundClientPlatform
	SET		FundId = @FundId, ClientPlatformId = @ClientPlatformId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	FundClientPlatformId = @FundClientPlatformId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FundClientPlatform
	WHERE	FundClientPlatformId = @FundClientPlatformId
	AND		@@ROWCOUNT > 0

GO
