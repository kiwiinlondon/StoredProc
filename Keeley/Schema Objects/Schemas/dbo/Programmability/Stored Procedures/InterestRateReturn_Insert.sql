USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InterestRateReturn_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InterestRateReturn_Insert]
GO

CREATE PROCEDURE DBO.[InterestRateReturn_Insert]
		@InstrumentMarketId int, 
		@ReferenceDate datetime, 
		@PriceId int, 
		@Value numeric(27,8), 
		@CurrencyId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into InterestRateReturn
			(InstrumentMarketId, ReferenceDate, PriceId, Value, CurrencyId, UpdateUserID, StartDt)
	VALUES
			(@InstrumentMarketId, @ReferenceDate, @PriceId, @Value, @CurrencyId, @UpdateUserID, @StartDt)

	SELECT	InterestRateReturnId, StartDt, DataVersion
	FROM	InterestRateReturn
	WHERE	InterestRateReturnId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
