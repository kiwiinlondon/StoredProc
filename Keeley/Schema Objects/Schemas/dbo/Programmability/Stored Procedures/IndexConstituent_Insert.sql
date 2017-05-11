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
		@ReferenceDate datetime, 
		@OpenWeight numeric(19,16), 
		@CumulativeOpenWeight numeric(19,16), 
		@UpdateUserID int, 
		@TotalReturn numeric(28,8), 
		@RebasedTotalReturn numeric(28,16), 
		@RebasedFxReturnEUR numeric(28,16), 
		@RebasedFxReturnGBP numeric(28,16), 
		@RebasedFxReturnUSD numeric(28,16), 
		@FxReturnEUR numeric(28,16), 
		@FxReturnGBP numeric(28,16), 
		@FxReturnUSD numeric(18,16)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into IndexConstituent
			(InstrumentId, ConstituentInstrumentMarketId, ReferenceDate, OpenWeight, CumulativeOpenWeight, UpdateUserID, TotalReturn, RebasedTotalReturn, RebasedFxReturnEUR, RebasedFxReturnGBP, RebasedFxReturnUSD, FxReturnEUR, FxReturnGBP, FxReturnUSD, StartDt)
	VALUES
			(@InstrumentId, @ConstituentInstrumentMarketId, @ReferenceDate, @OpenWeight, @CumulativeOpenWeight, @UpdateUserID, @TotalReturn, @RebasedTotalReturn, @RebasedFxReturnEUR, @RebasedFxReturnGBP, @RebasedFxReturnUSD, @FxReturnEUR, @FxReturnGBP, @FxReturnUSD, @StartDt)

	SELECT	IndexConstituentId, StartDt, DataVersion
	FROM	IndexConstituent
	WHERE	IndexConstituentId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
