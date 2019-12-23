USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundWebsiteCacheTime_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundWebsiteCacheTime_Delete]
GO

CREATE PROCEDURE DBO.[FundWebsiteCacheTime_Delete]
		@FundID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FundWebsiteCacheTime_hst (
			FundID, LastCleared, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FundID, LastCleared, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	FundWebsiteCacheTime
	WHERE	FundID = @FundID

	DELETE	FundWebsiteCacheTime
	WHERE	FundID = @FundID
	AND		DataVersion = @DataVersion
GO
