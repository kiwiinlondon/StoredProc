﻿USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InternalAllocation_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InternalAllocation_Insert]
GO

CREATE PROCEDURE DBO.[InternalAllocation_Insert]
		@EventID int, 
		@FMContEventInd varchar(1), 
		@FMContEventId int, 
		@FMOriginalContEventId int, 
		@MatchedStatusId int, 
		@AccountID int, 
		@BookID int, 
		@Quantity numeric(27,8), 
		@IsCancelled bit, 
		@UpdateUserID int, 
		@ParentEventId int, 
		@EventToBookFXRate numeric(35,16), 
		@StrategyId int, 
		@EventToBookFXRateOverride numeric(35,16), 
		@EzeTradeId varchar(15), 
		@EzeTicket varchar(15), 
		@NetConsideration numeric(27,8), 
		@GrossConsideration numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into InternalAllocation
			(EventID, FMContEventInd, FMContEventId, FMOriginalContEventId, MatchedStatusId, AccountID, BookID, Quantity, IsCancelled, UpdateUserID, ParentEventId, EventToBookFXRate, StrategyId, EventToBookFXRateOverride, EzeTradeId, EzeTicket, NetConsideration, GrossConsideration, StartDt)
	VALUES
			(@EventID, @FMContEventInd, @FMContEventId, @FMOriginalContEventId, @MatchedStatusId, @AccountID, @BookID, @Quantity, @IsCancelled, @UpdateUserID, @ParentEventId, @EventToBookFXRate, @StrategyId, @EventToBookFXRateOverride, @EzeTradeId, @EzeTicket, @NetConsideration, @GrossConsideration, @StartDt)

	SELECT	EventID, StartDt, DataVersion
	FROM	InternalAllocation
	WHERE	EventID = @EventID
	AND		@@ROWCOUNT > 0

GO
