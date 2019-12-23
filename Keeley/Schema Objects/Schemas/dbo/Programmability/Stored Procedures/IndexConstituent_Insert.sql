USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IndexConstituent_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IndexConstituent_Insert]
GO

CREATE PROCEDURE DBO.[IndexConstituent_Insert]
		@InstrumentId int, 
		@ConstituentInstrumentMarketId int, 
		@CurrencyId int, 
		@ReferenceDate datetime, 
		@OpenWeight numeric(25,19), 
		@PriceReturn numeric(25,19), 
		@TotalReturn numeric(25,19), 
		@FxReturn numeric(25,19), 
		@UpdateUserID int, 
		@ConstituentCurrencyId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into IndexConstituent
			(InstrumentId, ConstituentInstrumentMarketId, CurrencyId, ReferenceDate, OpenWeight, PriceReturn, TotalReturn, FxReturn, UpdateUserID, ConstituentCurrencyId, StartDt)
	VALUES
			(@InstrumentId, @ConstituentInstrumentMarketId, @CurrencyId, @ReferenceDate, @OpenWeight, @PriceReturn, @TotalReturn, @FxReturn, @UpdateUserID, @ConstituentCurrencyId, @StartDt)

	SELECT	IndexConstituentId, StartDt, DataVersion
	FROM	IndexConstituent
	WHERE	IndexConstituentId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
