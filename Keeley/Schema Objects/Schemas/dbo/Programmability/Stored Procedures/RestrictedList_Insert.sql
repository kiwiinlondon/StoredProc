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
		@UpdateUserID int, 
		@OpeningComment varchar(4000), 
		@ClosingComment varchar(4000), 
		@RestrictedPerson varchar(4000)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into RestrictedList
			(InstrumentId, EffvFromDt, EffvToDt, UpdateUserID, OpeningComment, ClosingComment, RestrictedPerson, StartDt)
	VALUES
			(@InstrumentId, @EffvFromDt, @EffvToDt, @UpdateUserID, @OpeningComment, @ClosingComment, @RestrictedPerson, @StartDt)

	SELECT	RestrictedListId, StartDt, DataVersion
	FROM	RestrictedList
	WHERE	RestrictedListId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
