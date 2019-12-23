USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Financing_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Financing_Delete]
GO

CREATE PROCEDURE DBO.[Financing_Delete]
		@FinancingId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Financing_hst (
			FinancingId, FundId, InstrumentMarketId, ReferenceDate, CurrencyId, CustodianId, NetPosition, Price, Notional, FinancingRate, BorrowRate, AllInRate, FinancingAccrual, BorrowAccrual, AllInAccrual, StartDt, UpdateUserID, DataVersion, OverborrowNotional, OverborrowUnits, OverborrowRate, OverborrowAccrual, MarginInterest, CashInterest, RelatedFinancingId, IsDummy, OverborrowFinancingAccrual, FinancingControlId, RehypothecationEarning, EndDt, LastActionUserID)
	SELECT	FinancingId, FundId, InstrumentMarketId, ReferenceDate, CurrencyId, CustodianId, NetPosition, Price, Notional, FinancingRate, BorrowRate, AllInRate, FinancingAccrual, BorrowAccrual, AllInAccrual, StartDt, UpdateUserID, DataVersion, OverborrowNotional, OverborrowUnits, OverborrowRate, OverborrowAccrual, MarginInterest, CashInterest, RelatedFinancingId, IsDummy, OverborrowFinancingAccrual, FinancingControlId, RehypothecationEarning, @EndDt, @UpdateUserID
	FROM	Financing
	WHERE	FinancingId = @FinancingId

	DELETE	Financing
	WHERE	FinancingId = @FinancingId
	AND		DataVersion = @DataVersion
GO
