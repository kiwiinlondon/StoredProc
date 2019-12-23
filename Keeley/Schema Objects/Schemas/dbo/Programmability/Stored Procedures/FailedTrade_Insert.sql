USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FailedTrade_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FailedTrade_Insert]
GO

CREATE PROCEDURE DBO.[FailedTrade_Insert]
		@EventId int, 
		@DaysToSettle int, 
		@FailedTradeReasonId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FailedTrade
			(EventId, DaysToSettle, FailedTradeReasonId, UpdateUserID, StartDt)
	VALUES
			(@EventId, @DaysToSettle, @FailedTradeReasonId, @UpdateUserID, @StartDt)

	SELECT	EventId, StartDt, DataVersion
	FROM	FailedTrade
	WHERE	EventId = @EventId
	AND		@@ROWCOUNT > 0

GO
