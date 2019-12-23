USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InterestRateSwapCashFlow_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InterestRateSwapCashFlow_Delete]
GO

CREATE PROCEDURE DBO.[InterestRateSwapCashFlow_Delete]
		@InstrumentId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO InterestRateSwapCashFlow_hst (
			InstrumentId, CashFlowDate, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	InstrumentId, CashFlowDate, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	InterestRateSwapCashFlow
	WHERE	InstrumentId = @InstrumentId

	DELETE	InterestRateSwapCashFlow
	WHERE	InstrumentId = @InstrumentId
	AND		DataVersion = @DataVersion
GO
