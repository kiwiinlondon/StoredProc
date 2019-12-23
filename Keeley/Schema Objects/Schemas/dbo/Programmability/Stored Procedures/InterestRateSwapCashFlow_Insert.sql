USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InterestRateSwapCashFlow_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InterestRateSwapCashFlow_Insert]
GO

CREATE PROCEDURE DBO.[InterestRateSwapCashFlow_Insert]
		@InstrumentId int, 
		@CashFlowDate datetime, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into InterestRateSwapCashFlow
			(InstrumentId, CashFlowDate, UpdateUserID, StartDt)
	VALUES
			(@InstrumentId, @CashFlowDate, @UpdateUserID, @StartDt)

	SELECT	InstrumentId, StartDt, DataVersion
	FROM	InterestRateSwapCashFlow
	WHERE	InstrumentId = @InstrumentId
	AND		@@ROWCOUNT > 0

GO
