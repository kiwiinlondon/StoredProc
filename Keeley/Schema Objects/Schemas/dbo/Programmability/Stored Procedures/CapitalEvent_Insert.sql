﻿USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[CapitalEvent_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[CapitalEvent_Insert]
GO

CREATE PROCEDURE DBO.[CapitalEvent_Insert]
		@EventID int, 
		@TradeDate datetime, 
		@SettlementDate datetime, 
		@Quantity numeric(27,8), 
		@AmendmentNumber int, 
		@IsCancelled bit, 
		@CurrencyId int, 
		@UpdateUserID int, 
		@InputDate datetime, 
		@AdministratorTradeDate datetime
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into CapitalEvent
			(EventID, TradeDate, SettlementDate, Quantity, AmendmentNumber, IsCancelled, CurrencyId, UpdateUserID, InputDate, AdministratorTradeDate, StartDt)
	VALUES
			(@EventID, @TradeDate, @SettlementDate, @Quantity, @AmendmentNumber, @IsCancelled, @CurrencyId, @UpdateUserID, @InputDate, @AdministratorTradeDate, @StartDt)

	SELECT	EventID, StartDt, DataVersion
	FROM	CapitalEvent
	WHERE	EventID = @EventID
	AND		@@ROWCOUNT > 0

GO
