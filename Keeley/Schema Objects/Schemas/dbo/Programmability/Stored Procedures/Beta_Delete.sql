USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Beta_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Beta_Delete]
GO

CREATE PROCEDURE DBO.[Beta_Delete]
		@BetaId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Beta_hst (
			BetaId, AnalyticTypeId, InstrumentMarketId, RelativeIndexInstrumentMarketId, CurrencyId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	BetaId, AnalyticTypeId, InstrumentMarketId, RelativeIndexInstrumentMarketId, CurrencyId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	Beta
	WHERE	BetaId = @BetaId

	DELETE	Beta
	WHERE	BetaId = @BetaId
	AND		DataVersion = @DataVersion
GO
