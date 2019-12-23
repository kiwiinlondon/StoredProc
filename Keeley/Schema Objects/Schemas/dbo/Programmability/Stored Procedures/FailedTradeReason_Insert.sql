USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FailedTradeReason_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FailedTradeReason_Insert]
GO

CREATE PROCEDURE DBO.[FailedTradeReason_Insert]
		@Reason varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FailedTradeReason
			(Reason, UpdateUserID, StartDt)
	VALUES
			(@Reason, @UpdateUserID, @StartDt)

	SELECT	FailedTradeReasonId, StartDt, DataVersion
	FROM	FailedTradeReason
	WHERE	FailedTradeReasonId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
