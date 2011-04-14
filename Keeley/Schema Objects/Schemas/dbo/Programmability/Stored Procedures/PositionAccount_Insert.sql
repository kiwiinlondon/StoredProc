USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PositionAccount_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PositionAccount_Insert]
GO

CREATE PROCEDURE DBO.[PositionAccount_Insert]
		@AccountID int, 
		@PositionId int, 
		@UpdateUserID int, 
		@BookID int, 
		@InstrumentMarketID int, 
		@CurrencyID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PositionAccount
			(AccountID, PositionId, UpdateUserID, BookID, InstrumentMarketID, CurrencyID, StartDt)
	VALUES
			(@AccountID, @PositionId, @UpdateUserID, @BookID, @InstrumentMarketID, @CurrencyID, @StartDt)

	SELECT	PositionAccountID, StartDt, DataVersion
	FROM	PositionAccount
	WHERE	PositionAccountID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
