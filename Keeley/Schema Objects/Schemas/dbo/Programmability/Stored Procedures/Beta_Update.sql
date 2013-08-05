USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Beta_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Beta_Update]
GO

CREATE PROCEDURE DBO.[Beta_Update]
		@BetaId int, 
		@BetaTypeId int, 
		@InstrumentMarketId int, 
		@RelativeIndexInstrumentMarketId int, 
		@CurrencyId int, 
		@ReferenceDate datetime, 
		@Value numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Beta_hst (
			BetaId, BetaTypeId, InstrumentMarketId, RelativeIndexInstrumentMarketId, CurrencyId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	BetaId, BetaTypeId, InstrumentMarketId, RelativeIndexInstrumentMarketId, CurrencyId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	Beta
	WHERE	BetaId = @BetaId

	UPDATE	Beta
	SET		BetaTypeId = @BetaTypeId, InstrumentMarketId = @InstrumentMarketId, RelativeIndexInstrumentMarketId = @RelativeIndexInstrumentMarketId, CurrencyId = @CurrencyId, ReferenceDate = @ReferenceDate, Value = @Value, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	BetaId = @BetaId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Beta
	WHERE	BetaId = @BetaId
	AND		@@ROWCOUNT > 0

GO
