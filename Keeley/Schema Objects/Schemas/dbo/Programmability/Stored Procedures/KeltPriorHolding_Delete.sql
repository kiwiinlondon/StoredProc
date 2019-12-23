USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[KeltPriorHolding_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[KeltPriorHolding_Delete]
GO

CREATE PROCEDURE DBO.[KeltPriorHolding_Delete]
		@KeltPriorHoldingId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO KeltPriorHolding_hst (
			KeltPriorHoldingId, InstrumentMarketId, ReferenceDate, Weighting, NumberOfShares, Price, EndDt, LastActionUserID)
	SELECT	KeltPriorHoldingId, InstrumentMarketId, ReferenceDate, Weighting, NumberOfShares, Price, @EndDt, @UpdateUserID
	FROM	KeltPriorHolding
	WHERE	KeltPriorHoldingId = @KeltPriorHoldingId

	DELETE	KeltPriorHolding
	WHERE	KeltPriorHoldingId = @KeltPriorHoldingId
	AND		DataVersion = @DataVersion
GO
