USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Financing_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Financing_Insert]
GO

CREATE PROCEDURE DBO.[Financing_Insert]
		@FundId int, 
		@InstrumentMarketId int, 
		@ReferenceDate datetime, 
		@CurrencyId int, 
		@CustodianId int, 
		@NetPosition numeric(27,8), 
		@Price numeric(27,8), 
		@Notional numeric(27,8), 
		@FinancingRate numeric(27,8), 
		@BorrowRate numeric(27,8), 
		@AllInRate numeric(27,8), 
		@FinancingAccrual numeric(27,8), 
		@BorrowAccrual numeric(27,8), 
		@AllInAccrual numeric(27,8), 
		@UpdateUserID int, 
		@OverborrowNotional numeric(27,8), 
		@OverborrowUnits numeric(27,8), 
		@OverborrowRate numeric(27,8), 
		@OverborrowAccrual numeric(27,8), 
		@MarginInterest numeric(27,8), 
		@CashInterest numeric(27,8), 
		@RelatedFinancingId int, 
		@IsDummy bit, 
		@OverborrowFinancingAccrual numeric(27,8), 
		@FinancingControlId int, 
		@RehypothecationEarning numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Financing
			(FundId, InstrumentMarketId, ReferenceDate, CurrencyId, CustodianId, NetPosition, Price, Notional, FinancingRate, BorrowRate, AllInRate, FinancingAccrual, BorrowAccrual, AllInAccrual, UpdateUserID, OverborrowNotional, OverborrowUnits, OverborrowRate, OverborrowAccrual, MarginInterest, CashInterest, RelatedFinancingId, IsDummy, OverborrowFinancingAccrual, FinancingControlId, RehypothecationEarning, StartDt)
	VALUES
			(@FundId, @InstrumentMarketId, @ReferenceDate, @CurrencyId, @CustodianId, @NetPosition, @Price, @Notional, @FinancingRate, @BorrowRate, @AllInRate, @FinancingAccrual, @BorrowAccrual, @AllInAccrual, @UpdateUserID, @OverborrowNotional, @OverborrowUnits, @OverborrowRate, @OverborrowAccrual, @MarginInterest, @CashInterest, @RelatedFinancingId, @IsDummy, @OverborrowFinancingAccrual, @FinancingControlId, @RehypothecationEarning, @StartDt)

	SELECT	FinancingId, StartDt, DataVersion
	FROM	Financing
	WHERE	FinancingId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
