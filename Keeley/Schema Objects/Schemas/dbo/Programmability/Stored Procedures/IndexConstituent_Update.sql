USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IndexConstituent_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IndexConstituent_Update]
GO

CREATE PROCEDURE DBO.[IndexConstituent_Update]
		@IndexConstituentId int, 
		@InstrumentId int, 
		@ConstituentInstrumentMarketId int, 
		@ReferenceDate datetime, 
		@OpenWeight numeric(19,16), 
		@CumulativeOpenWeight numeric(19,16), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
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

	INSERT INTO IndexConstituent_hst (
			IndexConstituentId, InstrumentId, ConstituentInstrumentMarketId, ReferenceDate, OpenWeight, CumulativeOpenWeight, StartDt, UpdateUserID, DataVersion, TotalReturn, RebasedTotalReturn, RebasedFxReturnEUR, RebasedFxReturnGBP, RebasedFxReturnUSD, FxReturnEUR, FxReturnGBP, FxReturnUSD, EndDt, LastActionUserID)
	SELECT	IndexConstituentId, InstrumentId, ConstituentInstrumentMarketId, ReferenceDate, OpenWeight, CumulativeOpenWeight, StartDt, UpdateUserID, DataVersion, TotalReturn, RebasedTotalReturn, RebasedFxReturnEUR, RebasedFxReturnGBP, RebasedFxReturnUSD, FxReturnEUR, FxReturnGBP, FxReturnUSD, @StartDt, @UpdateUserID
	FROM	IndexConstituent
	WHERE	IndexConstituentId = @IndexConstituentId

	UPDATE	IndexConstituent
	SET		InstrumentId = @InstrumentId, ConstituentInstrumentMarketId = @ConstituentInstrumentMarketId, ReferenceDate = @ReferenceDate, OpenWeight = @OpenWeight, CumulativeOpenWeight = @CumulativeOpenWeight, UpdateUserID = @UpdateUserID, TotalReturn = @TotalReturn, RebasedTotalReturn = @RebasedTotalReturn, RebasedFxReturnEUR = @RebasedFxReturnEUR, RebasedFxReturnGBP = @RebasedFxReturnGBP, RebasedFxReturnUSD = @RebasedFxReturnUSD, FxReturnEUR = @FxReturnEUR, FxReturnGBP = @FxReturnGBP, FxReturnUSD = @FxReturnUSD,  StartDt = @StartDt
	WHERE	IndexConstituentId = @IndexConstituentId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	IndexConstituent
	WHERE	IndexConstituentId = @IndexConstituentId
	AND		@@ROWCOUNT > 0

GO
