USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PADealingBalance_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PADealingBalance_Insert]
GO

CREATE PROCEDURE DBO.[PADealingBalance_Insert]
		@UserID int, 
		@InstrumentMarketID int, 
		@UserAccountID int, 
		@Quantity numeric(27,8), 
		@UpdateUserID int, 
		@LastPADealDate datetime, 
		@CurrentPrice numeric(27,8), 
		@CurrentPriceId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PADealingBalance
			(UserID, InstrumentMarketID, UserAccountID, Quantity, UpdateUserID, LastPADealDate, CurrentPrice, CurrentPriceId, StartDt)
	VALUES
			(@UserID, @InstrumentMarketID, @UserAccountID, @Quantity, @UpdateUserID, @LastPADealDate, @CurrentPrice, @CurrentPriceId, @StartDt)

	SELECT	PADealingBalanceID, StartDt, DataVersion
	FROM	PADealingBalance
	WHERE	PADealingBalanceID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
