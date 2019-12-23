USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundWebsiteCacheTime_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundWebsiteCacheTime_Insert]
GO

CREATE PROCEDURE DBO.[FundWebsiteCacheTime_Insert]
		@FundID int, 
		@LastCleared datetime, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FundWebsiteCacheTime
			(FundID, LastCleared, UpdateUserID, StartDt)
	VALUES
			(@FundID, @LastCleared, @UpdateUserID, @StartDt)

	SELECT	FundID, StartDt, DataVersion
	FROM	FundWebsiteCacheTime
	WHERE	FundID = @FundID
	AND		@@ROWCOUNT > 0

GO
