USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InterestRateReturn_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InterestRateReturn_Delete]
GO

CREATE PROCEDURE DBO.[InterestRateReturn_Delete]
		@InterestRateReturnId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO InterestRateReturn_hst (
			InterestRateReturnId, InstrumentMarketId, ReferenceDate, PriceId, StartDt, Value, CurrencyId, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	InterestRateReturnId, InstrumentMarketId, ReferenceDate, PriceId, StartDt, Value, CurrencyId, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	InterestRateReturn
	WHERE	InterestRateReturnId = @InterestRateReturnId

	DELETE	InterestRateReturn
	WHERE	InterestRateReturnId = @InterestRateReturnId
	AND		DataVersion = @DataVersion
GO
