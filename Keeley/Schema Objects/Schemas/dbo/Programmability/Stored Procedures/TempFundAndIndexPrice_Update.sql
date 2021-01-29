USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TempFundAndIndexPrice_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TempFundAndIndexPrice_Update]
GO

CREATE PROCEDURE DBO.[TempFundAndIndexPrice_Update]
		@PriceId int, 
		@InstrumentMarketId int, 
		@ReferenceDate datetime, 
		@Value numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO TempFundAndIndexPrice_hst (
			PriceId, InstrumentMarketId, ReferenceDate, Value, EndDt, LastActionUserID)
	SELECT	PriceId, InstrumentMarketId, ReferenceDate, Value, @StartDt, @UpdateUserID
	FROM	TempFundAndIndexPrice
	WHERE	PriceId = @PriceId

	UPDATE	TempFundAndIndexPrice
	SET		InstrumentMarketId = @InstrumentMarketId, ReferenceDate = @ReferenceDate, Value = @Value,  StartDt = @StartDt
	WHERE	PriceId = @PriceId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	TempFundAndIndexPrice
	WHERE	PriceId = @PriceId
	AND		@@ROWCOUNT > 0

GO
