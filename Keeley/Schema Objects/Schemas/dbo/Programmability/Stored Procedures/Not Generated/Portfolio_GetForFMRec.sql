USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Portfolio_GetForFMRec]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Portfolio_GetForFMRec]
GO

CREATE PROCEDURE [DBO].[Portfolio_GetForFMRec]
	@fundId int, 
	@fromDt datetime,
	@toDt datetime
AS
	select	p.ReferenceDate,
		b.FMOrgId,
		im.FMSecId,
		ccy.Name,
		NetPosition, 
		UnitCost,
		MarkPrice,
		FXRate,
		MarketValue,
		DeltaEquityPosition,
		Accrual,
		CashIncome,
		RealisedFXPNL,
		UnRealisedFXPNL,
		RealisedPricePNL,
		UnRealisedPricePNL
from	Portfolio p,
		Position pos,
		Book b,
		InstrumentMarket im,
		Instrument ccy
where	p.PositionID = pos.PositionID
and		pos.BookID = b.BookID
and		pos.InstrumentMarketID = im.InstrumentMarketID
and		pos.CurrencyID = ccy.InstrumentID
and		b.FundID = @fundId
and		p.ReferenceDate between @fromDt and @toDt