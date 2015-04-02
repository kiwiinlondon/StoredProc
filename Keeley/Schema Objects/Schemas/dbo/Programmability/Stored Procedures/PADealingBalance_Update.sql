USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PADealingBalance_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PADealingBalance_Update]
GO

CREATE PROCEDURE DBO.[PADealingBalance_Update]
		@PADealingBalanceID int, 
		@UserID int, 
		@InstrumentMarketID int, 
		@UserAccountID int, 
		@Quantity numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@LastPADealDate datetime, 
		@CurrentPrice numeric(27,8), 
		@CurrentPriceId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PADealingBalance_hst (
			PADealingBalanceID, UserID, InstrumentMarketID, UserAccountID, Quantity, StartDt, UpdateUserID, DataVersion, LastPADealDate, CurrentPrice, CurrentPriceId, EndDt, LastActionUserID)
	SELECT	PADealingBalanceID, UserID, InstrumentMarketID, UserAccountID, Quantity, StartDt, UpdateUserID, DataVersion, LastPADealDate, CurrentPrice, CurrentPriceId, @StartDt, @UpdateUserID
	FROM	PADealingBalance
	WHERE	PADealingBalanceID = @PADealingBalanceID

	UPDATE	PADealingBalance
	SET		UserID = @UserID, InstrumentMarketID = @InstrumentMarketID, UserAccountID = @UserAccountID, Quantity = @Quantity, UpdateUserID = @UpdateUserID, LastPADealDate = @LastPADealDate, CurrentPrice = @CurrentPrice, CurrentPriceId = @CurrentPriceId,  StartDt = @StartDt
	WHERE	PADealingBalanceID = @PADealingBalanceID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PADealingBalance
	WHERE	PADealingBalanceID = @PADealingBalanceID
	AND		@@ROWCOUNT > 0

GO
