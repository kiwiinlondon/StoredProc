USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[KeltPriorHolding_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[KeltPriorHolding_Insert]
GO

CREATE PROCEDURE DBO.[KeltPriorHolding_Insert]
		@InstrumentMarketId int, 
		@ReferenceDate datetime, 
		@Weighting numeric(27,8), 
		@NumberOfShares numeric(27,8), 
		@Price numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into KeltPriorHolding
			(InstrumentMarketId, ReferenceDate, Weighting, NumberOfShares, Price, StartDt)
	VALUES
			(@InstrumentMarketId, @ReferenceDate, @Weighting, @NumberOfShares, @Price, @StartDt)

	SELECT	KeltPriorHoldingId, StartDt, DataVersion
	FROM	KeltPriorHolding
	WHERE	KeltPriorHoldingId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
