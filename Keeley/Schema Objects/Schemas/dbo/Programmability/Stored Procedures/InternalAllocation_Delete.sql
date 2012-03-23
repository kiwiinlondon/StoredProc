USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InternalAllocation_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InternalAllocation_Delete]
GO

CREATE PROCEDURE DBO.[InternalAllocation_Delete]
		@EventID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO InternalAllocation_hst (
			EventID, FMContEventInd, FMContEventId, FMOriginalContEventId, MatchedStatusId, AccountID, BookID, Quantity, IsCancelled, StartDt, UpdateUserID, DataVersion, ParentEventId, EventToBookFXRate, EndDt, LastActionUserID)
	SELECT	EventID, FMContEventInd, FMContEventId, FMOriginalContEventId, MatchedStatusId, AccountID, BookID, Quantity, IsCancelled, StartDt, UpdateUserID, DataVersion, ParentEventId, EventToBookFXRate, @EndDt, @UpdateUserID
	FROM	InternalAllocation
	WHERE	EventID = @EventID

	DELETE	InternalAllocation
	WHERE	EventID = @EventID
	AND		DataVersion = @DataVersion
GO
