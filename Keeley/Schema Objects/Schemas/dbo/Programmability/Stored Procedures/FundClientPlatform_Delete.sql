USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundClientPlatform_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundClientPlatform_Delete]
GO

CREATE PROCEDURE DBO.[FundClientPlatform_Delete]
		@FundClientPlatformId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FundClientPlatform_hst (
			FundClientPlatformId, FundId, ClientPlatformId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FundClientPlatformId, FundId, ClientPlatformId, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	FundClientPlatform
	WHERE	FundClientPlatformId = @FundClientPlatformId

	DELETE	FundClientPlatform
	WHERE	FundClientPlatformId = @FundClientPlatformId
	AND		DataVersion = @DataVersion
GO
