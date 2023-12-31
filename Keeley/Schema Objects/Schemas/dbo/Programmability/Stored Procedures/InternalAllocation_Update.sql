﻿USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InternalAllocation_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InternalAllocation_Update]
GO

CREATE PROCEDURE DBO.[InternalAllocation_Update]
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
		@DataVersion rowversion, 
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

	INSERT INTO InternalAllocation_hst (
			EventID, FMContEventInd, FMContEventId, FMOriginalContEventId, MatchedStatusId, AccountID, BookID, Quantity, IsCancelled, StartDt, UpdateUserID, DataVersion, ParentEventId, EventToBookFXRate, StrategyId, EventToBookFXRateOverride, EzeTradeId, EzeTicket, NetConsideration, GrossConsideration, EndDt, LastActionUserID)
	SELECT	EventID, FMContEventInd, FMContEventId, FMOriginalContEventId, MatchedStatusId, AccountID, BookID, Quantity, IsCancelled, StartDt, UpdateUserID, DataVersion, ParentEventId, EventToBookFXRate, StrategyId, EventToBookFXRateOverride, EzeTradeId, EzeTicket, NetConsideration, GrossConsideration, @StartDt, @UpdateUserID
	FROM	InternalAllocation
	WHERE	EventID = @EventID

	UPDATE	InternalAllocation
	SET		FMContEventInd = @FMContEventInd, FMContEventId = @FMContEventId, FMOriginalContEventId = @FMOriginalContEventId, MatchedStatusId = @MatchedStatusId, AccountID = @AccountID, BookID = @BookID, Quantity = @Quantity, IsCancelled = @IsCancelled, UpdateUserID = @UpdateUserID, ParentEventId = @ParentEventId, EventToBookFXRate = @EventToBookFXRate, StrategyId = @StrategyId, EventToBookFXRateOverride = @EventToBookFXRateOverride, EzeTradeId = @EzeTradeId, EzeTicket = @EzeTicket, NetConsideration = @NetConsideration, GrossConsideration = @GrossConsideration,  StartDt = @StartDt
	WHERE	EventID = @EventID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	InternalAllocation
	WHERE	EventID = @EventID
	AND		@@ROWCOUNT > 0

GO
