USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FailedTradeReason_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FailedTradeReason_Delete]
GO

CREATE PROCEDURE DBO.[FailedTradeReason_Delete]
		@FailedTradeReasonId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FailedTradeReason_hst (
			FailedTradeReasonId, Reason, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FailedTradeReasonId, Reason, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	FailedTradeReason
	WHERE	FailedTradeReasonId = @FailedTradeReasonId

	DELETE	FailedTradeReason
	WHERE	FailedTradeReasonId = @FailedTradeReasonId
	AND		DataVersion = @DataVersion
GO
