USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EnforcePositionEvent_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EnforcePositionEvent_Insert]
GO

CREATE PROCEDURE DBO.[EnforcePositionEvent_Insert]
		@EventID int, 
		@ReferenceDate datetime, 
		@AmendmentNumber int, 
		@InstrumentMarketId int, 
		@IsCancelled bit, 
		@CurrencyId int, 
		@UpdateUserID int, 
		@InputDate datetime, 
		@MustExistEntityTypeId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into EnforcePositionEvent
			(EventID, ReferenceDate, AmendmentNumber, InstrumentMarketId, IsCancelled, CurrencyId, UpdateUserID, InputDate, MustExistEntityTypeId, StartDt)
	VALUES
			(@EventID, @ReferenceDate, @AmendmentNumber, @InstrumentMarketId, @IsCancelled, @CurrencyId, @UpdateUserID, @InputDate, @MustExistEntityTypeId, @StartDt)

	SELECT	EventID, StartDt, DataVersion
	FROM	EnforcePositionEvent
	WHERE	EventID = @EventID
	AND		@@ROWCOUNT > 0

GO
