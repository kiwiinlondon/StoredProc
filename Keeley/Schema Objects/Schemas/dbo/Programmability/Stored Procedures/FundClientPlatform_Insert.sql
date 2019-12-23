USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundClientPlatform_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundClientPlatform_Insert]
GO

CREATE PROCEDURE DBO.[FundClientPlatform_Insert]
		@FundId int, 
		@ClientPlatformId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FundClientPlatform
			(FundId, ClientPlatformId, UpdateUserID, StartDt)
	VALUES
			(@FundId, @ClientPlatformId, @UpdateUserID, @StartDt)

	SELECT	FundClientPlatformId, StartDt, DataVersion
	FROM	FundClientPlatform
	WHERE	FundClientPlatformId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
