USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[KeltPriorHolding_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[KeltPriorHolding_Update]
GO

CREATE PROCEDURE DBO.[KeltPriorHolding_Update]
		@KeltPriorHoldingId int, 
		@InstrumentMarketId int, 
		@ReferenceDate datetime, 
		@Weighting numeric(27,8), 
		@NumberOfShares numeric(27,8), 
		@Price numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO KeltPriorHolding_hst (
			KeltPriorHoldingId, InstrumentMarketId, ReferenceDate, Weighting, NumberOfShares, Price, EndDt, LastActionUserID)
	SELECT	KeltPriorHoldingId, InstrumentMarketId, ReferenceDate, Weighting, NumberOfShares, Price, @StartDt, @UpdateUserID
	FROM	KeltPriorHolding
	WHERE	KeltPriorHoldingId = @KeltPriorHoldingId

	UPDATE	KeltPriorHolding
	SET		InstrumentMarketId = @InstrumentMarketId, ReferenceDate = @ReferenceDate, Weighting = @Weighting, NumberOfShares = @NumberOfShares, Price = @Price,  StartDt = @StartDt
	WHERE	KeltPriorHoldingId = @KeltPriorHoldingId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	KeltPriorHolding
	WHERE	KeltPriorHoldingId = @KeltPriorHoldingId
	AND		@@ROWCOUNT > 0

GO
