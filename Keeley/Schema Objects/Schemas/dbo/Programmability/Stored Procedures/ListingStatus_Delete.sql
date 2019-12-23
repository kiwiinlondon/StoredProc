USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ListingStatus_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ListingStatus_Delete]
GO

CREATE PROCEDURE DBO.[ListingStatus_Delete]
		@ListingStatusId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ListingStatus_hst (
			ListingStatusId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ListingStatusId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ListingStatus
	WHERE	ListingStatusId = @ListingStatusId

	DELETE	ListingStatus
	WHERE	ListingStatusId = @ListingStatusId
	AND		DataVersion = @DataVersion
GO
