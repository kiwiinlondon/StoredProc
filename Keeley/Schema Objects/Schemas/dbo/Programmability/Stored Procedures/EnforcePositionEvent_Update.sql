USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EnforcePositionEvent_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EnforcePositionEvent_Update]
GO

CREATE PROCEDURE DBO.[EnforcePositionEvent_Update]
		@EventID int, 
		@ReferenceDate datetime, 
		@AmendmentNumber int, 
		@InstrumentMarketId int, 
		@IsCancelled bit, 
		@CurrencyId int, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@InputDate datetime, 
		@MustExistEntityTypeId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO EnforcePositionEvent_hst (
			EventID, ReferenceDate, AmendmentNumber, InstrumentMarketId, IsCancelled, CurrencyId, StartDt, UpdateUserID, DataVersion, InputDate, MustExistEntityTypeId, EndDt, LastActionUserID)
	SELECT	EventID, ReferenceDate, AmendmentNumber, InstrumentMarketId, IsCancelled, CurrencyId, StartDt, UpdateUserID, DataVersion, InputDate, MustExistEntityTypeId, @StartDt, @UpdateUserID
	FROM	EnforcePositionEvent
	WHERE	EventID = @EventID

	UPDATE	EnforcePositionEvent
	SET		ReferenceDate = @ReferenceDate, AmendmentNumber = @AmendmentNumber, InstrumentMarketId = @InstrumentMarketId, IsCancelled = @IsCancelled, CurrencyId = @CurrencyId, UpdateUserID = @UpdateUserID, InputDate = @InputDate, MustExistEntityTypeId = @MustExistEntityTypeId,  StartDt = @StartDt
	WHERE	EventID = @EventID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	EnforcePositionEvent
	WHERE	EventID = @EventID
	AND		@@ROWCOUNT > 0

GO
