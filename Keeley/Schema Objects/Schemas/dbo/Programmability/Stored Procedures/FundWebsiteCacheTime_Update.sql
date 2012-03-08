USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundWebsiteCacheTime_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundWebsiteCacheTime_Update]
GO

CREATE PROCEDURE DBO.[FundWebsiteCacheTime_Update]
		@FundID int, 
		@LastCleared datetime, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FundWebsiteCacheTime_hst (
			FundID, LastCleared, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FundID, LastCleared, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	FundWebsiteCacheTime
	WHERE	FundID = @FundID

	UPDATE	FundWebsiteCacheTime
	SET		LastCleared = @LastCleared, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	FundID = @FundID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FundWebsiteCacheTime
	WHERE	FundID = @FundID
	AND		@@ROWCOUNT > 0

GO
