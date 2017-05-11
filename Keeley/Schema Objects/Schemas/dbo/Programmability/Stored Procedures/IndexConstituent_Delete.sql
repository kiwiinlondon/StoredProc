USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IndexConstituent_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IndexConstituent_Delete]
GO

CREATE PROCEDURE DBO.[IndexConstituent_Delete]
		@IndexConstituentId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO IndexConstituent_hst (
			IndexConstituentId, InstrumentId, ConstituentInstrumentMarketId, ReferenceDate, OpenWeight, CumulativeOpenWeight, StartDt, UpdateUserID, DataVersion, TotalReturn, RebasedTotalReturn, RebasedFxReturnEUR, RebasedFxReturnGBP, RebasedFxReturnUSD, FxReturnEUR, FxReturnGBP, FxReturnUSD, EndDt, LastActionUserID)
	SELECT	IndexConstituentId, InstrumentId, ConstituentInstrumentMarketId, ReferenceDate, OpenWeight, CumulativeOpenWeight, StartDt, UpdateUserID, DataVersion, TotalReturn, RebasedTotalReturn, RebasedFxReturnEUR, RebasedFxReturnGBP, RebasedFxReturnUSD, FxReturnEUR, FxReturnGBP, FxReturnUSD, @EndDt, @UpdateUserID
	FROM	IndexConstituent
	WHERE	IndexConstituentId = @IndexConstituentId

	DELETE	IndexConstituent
	WHERE	IndexConstituentId = @IndexConstituentId
	AND		DataVersion = @DataVersion
GO
