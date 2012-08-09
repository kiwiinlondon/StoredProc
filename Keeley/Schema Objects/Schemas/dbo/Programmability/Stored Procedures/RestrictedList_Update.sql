USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RestrictedList_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RestrictedList_Update]
GO

CREATE PROCEDURE DBO.[RestrictedList_Update]
		@RestrictedListId int, 
		@InstrumentId int, 
		@EffvFromDt datetime, 
		@EffvToDt datetime, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO RestrictedList_hst (
			RestrictedListId, InstrumentId, EffvFromDt, EffvToDt, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	RestrictedListId, InstrumentId, EffvFromDt, EffvToDt, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	RestrictedList
	WHERE	RestrictedListId = @RestrictedListId

	UPDATE	RestrictedList
	SET		InstrumentId = @InstrumentId, EffvFromDt = @EffvFromDt, EffvToDt = @EffvToDt, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	RestrictedListId = @RestrictedListId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	RestrictedList
	WHERE	RestrictedListId = @RestrictedListId
	AND		@@ROWCOUNT > 0

GO
