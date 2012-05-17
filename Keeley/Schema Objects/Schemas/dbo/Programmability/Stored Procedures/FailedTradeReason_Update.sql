USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FailedTradeReason_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FailedTradeReason_Update]
GO

CREATE PROCEDURE DBO.[FailedTradeReason_Update]
		@FailedTradeReasonId int, 
		@Reason varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FailedTradeReason_hst (
			FailedTradeReasonId, Reason, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FailedTradeReasonId, Reason, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	FailedTradeReason
	WHERE	FailedTradeReasonId = @FailedTradeReasonId

	UPDATE	FailedTradeReason
	SET		Reason = @Reason, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	FailedTradeReasonId = @FailedTradeReasonId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FailedTradeReason
	WHERE	FailedTradeReasonId = @FailedTradeReasonId
	AND		@@ROWCOUNT > 0

GO
