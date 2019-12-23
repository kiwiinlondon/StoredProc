USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EnforcePositionEvent_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EnforcePositionEvent_Delete]
GO

CREATE PROCEDURE DBO.[EnforcePositionEvent_Delete]
		@EventID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO EnforcePositionEvent_hst (
			EventID, ReferenceDate, AmendmentNumber, InstrumentMarketId, IsCancelled, CurrencyId, StartDt, UpdateUserID, DataVersion, InputDate, MustExistEntityTypeId, EndDt, LastActionUserID)
	SELECT	EventID, ReferenceDate, AmendmentNumber, InstrumentMarketId, IsCancelled, CurrencyId, StartDt, UpdateUserID, DataVersion, InputDate, MustExistEntityTypeId, @EndDt, @UpdateUserID
	FROM	EnforcePositionEvent
	WHERE	EventID = @EventID

	DELETE	EnforcePositionEvent
	WHERE	EventID = @EventID
	AND		DataVersion = @DataVersion
GO
