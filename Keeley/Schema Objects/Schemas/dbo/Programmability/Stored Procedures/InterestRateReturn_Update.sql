USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InterestRateReturn_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InterestRateReturn_Update]
GO

CREATE PROCEDURE DBO.[InterestRateReturn_Update]
		@InterestRateReturnId int, 
		@InstrumentMarketId int, 
		@ReferenceDate datetime, 
		@PriceId int, 
		@Value numeric(27,8), 
		@CurrencyId int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO InterestRateReturn_hst (
			InterestRateReturnId, InstrumentMarketId, ReferenceDate, PriceId, StartDt, Value, CurrencyId, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	InterestRateReturnId, InstrumentMarketId, ReferenceDate, PriceId, StartDt, Value, CurrencyId, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	InterestRateReturn
	WHERE	InterestRateReturnId = @InterestRateReturnId

	UPDATE	InterestRateReturn
	SET		InstrumentMarketId = @InstrumentMarketId, ReferenceDate = @ReferenceDate, PriceId = @PriceId, Value = @Value, CurrencyId = @CurrencyId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	InterestRateReturnId = @InterestRateReturnId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	InterestRateReturn
	WHERE	InterestRateReturnId = @InterestRateReturnId
	AND		@@ROWCOUNT > 0

GO
