USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PADealingBalance_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PADealingBalance_Delete]
GO

CREATE PROCEDURE DBO.[PADealingBalance_Delete]
		@PADealingBalanceID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PADealingBalance_hst (
			PADealingBalanceID, UserID, InstrumentMarketID, UserAccountID, Quantity, StartDt, UpdateUserID, DataVersion, LastPADealDate, CurrentPrice, CurrentPriceId, EndDt, LastActionUserID)
	SELECT	PADealingBalanceID, UserID, InstrumentMarketID, UserAccountID, Quantity, StartDt, UpdateUserID, DataVersion, LastPADealDate, CurrentPrice, CurrentPriceId, @EndDt, @UpdateUserID
	FROM	PADealingBalance
	WHERE	PADealingBalanceID = @PADealingBalanceID

	DELETE	PADealingBalance
	WHERE	PADealingBalanceID = @PADealingBalanceID
	AND		DataVersion = @DataVersion
GO
