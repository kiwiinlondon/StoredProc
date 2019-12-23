USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InterestRateSwapCashFlow_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InterestRateSwapCashFlow_Update]
GO

CREATE PROCEDURE DBO.[InterestRateSwapCashFlow_Update]
		@InstrumentId int, 
		@CashFlowDate datetime, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO InterestRateSwapCashFlow_hst (
			InstrumentId, CashFlowDate, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	InstrumentId, CashFlowDate, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	InterestRateSwapCashFlow
	WHERE	InstrumentId = @InstrumentId

	UPDATE	InterestRateSwapCashFlow
	SET		CashFlowDate = @CashFlowDate, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	InstrumentId = @InstrumentId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	InterestRateSwapCashFlow
	WHERE	InstrumentId = @InstrumentId
	AND		@@ROWCOUNT > 0

GO
