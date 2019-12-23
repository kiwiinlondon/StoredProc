USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FailedTrade_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FailedTrade_Update]
GO

CREATE PROCEDURE DBO.[FailedTrade_Update]
		@EventId int, 
		@DaysToSettle int, 
		@FailedTradeReasonId int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FailedTrade_hst (
			EventId, DaysToSettle, FailedTradeReasonId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EventId, DaysToSettle, FailedTradeReasonId, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	FailedTrade
	WHERE	EventId = @EventId

	UPDATE	FailedTrade
	SET		DaysToSettle = @DaysToSettle, FailedTradeReasonId = @FailedTradeReasonId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	EventId = @EventId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FailedTrade
	WHERE	EventId = @EventId
	AND		@@ROWCOUNT > 0

GO
