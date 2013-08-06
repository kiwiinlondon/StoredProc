USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Beta_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Beta_Insert]
GO

CREATE PROCEDURE DBO.[Beta_Insert]
		@AnalyticTypeId int, 
		@InstrumentMarketId int, 
		@RelativeIndexInstrumentMarketId int, 
		@CurrencyId int, 
		@ReferenceDate datetime, 
		@Value numeric(27,8), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Beta
			(AnalyticTypeId, InstrumentMarketId, RelativeIndexInstrumentMarketId, CurrencyId, ReferenceDate, Value, UpdateUserID, StartDt)
	VALUES
			(@AnalyticTypeId, @InstrumentMarketId, @RelativeIndexInstrumentMarketId, @CurrencyId, @ReferenceDate, @Value, @UpdateUserID, @StartDt)

	SELECT	BetaId, StartDt, DataVersion
	FROM	Beta
	WHERE	BetaId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
