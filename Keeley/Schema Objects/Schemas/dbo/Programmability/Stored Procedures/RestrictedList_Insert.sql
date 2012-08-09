USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RestrictedList_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RestrictedList_Insert]
GO

CREATE PROCEDURE DBO.[RestrictedList_Insert]
		@InstrumentId int, 
		@EffvFromDt datetime, 
		@EffvToDt datetime, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into RestrictedList
			(InstrumentId, EffvFromDt, EffvToDt, UpdateUserID, StartDt)
	VALUES
			(@InstrumentId, @EffvFromDt, @EffvToDt, @UpdateUserID, @StartDt)

	SELECT	RestrictedListId, StartDt, DataVersion
	FROM	RestrictedList
	WHERE	RestrictedListId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
