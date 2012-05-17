USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FailedTrade_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FailedTrade_Delete]
GO

CREATE PROCEDURE DBO.[FailedTrade_Delete]
		@EventId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FailedTrade_hst (
			EventId, DaysToSettle, FailedTradeReasonId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EventId, DaysToSettle, FailedTradeReasonId, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	FailedTrade
	WHERE	EventId = @EventId

	DELETE	FailedTrade
	WHERE	EventId = @EventId
	AND		DataVersion = @DataVersion
GO
