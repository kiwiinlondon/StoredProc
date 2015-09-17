USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RestrictedList_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RestrictedList_Delete]
GO

CREATE PROCEDURE DBO.[RestrictedList_Delete]
		@RestrictedListId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO RestrictedList_hst (
			RestrictedListId, InstrumentId, EffvFromDt, EffvToDt, StartDt, UpdateUserID, DataVersion, OpeningComment, ClosingComment, RestrictedPerson, WatchListOnly, EndDt, LastActionUserID)
	SELECT	RestrictedListId, InstrumentId, EffvFromDt, EffvToDt, StartDt, UpdateUserID, DataVersion, OpeningComment, ClosingComment, RestrictedPerson, WatchListOnly, @EndDt, @UpdateUserID
	FROM	RestrictedList
	WHERE	RestrictedListId = @RestrictedListId

	DELETE	RestrictedList
	WHERE	RestrictedListId = @RestrictedListId
	AND		DataVersion = @DataVersion
GO
