USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ListingStatus_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ListingStatus_Update]
GO

CREATE PROCEDURE DBO.[ListingStatus_Update]
		@ListingStatusId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ListingStatus_hst (
			ListingStatusId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ListingStatusId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ListingStatus
	WHERE	ListingStatusId = @ListingStatusId

	UPDATE	ListingStatus
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ListingStatusId = @ListingStatusId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ListingStatus
	WHERE	ListingStatusId = @ListingStatusId
	AND		@@ROWCOUNT > 0

GO
