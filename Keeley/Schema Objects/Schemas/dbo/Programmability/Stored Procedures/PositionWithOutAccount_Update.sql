USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PositionWithOutAccount_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PositionWithOutAccount_Update]
GO

CREATE PROCEDURE DBO.[PositionWithOutAccount_Update]
		@PositionID int, 
		@BookID int, 
		@InstrumentMarketID int, 
		@CurrencyID int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PositionWithOutAccount_hst (
			PositionID, BookID, InstrumentMarketID, CurrencyID, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PositionID, BookID, InstrumentMarketID, CurrencyID, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	PositionWithOutAccount
	WHERE	PositionID = @PositionID

	UPDATE	PositionWithOutAccount
	SET		BookID = @BookID, InstrumentMarketID = @InstrumentMarketID, CurrencyID = @CurrencyID, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	PositionID = @PositionID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PositionWithOutAccount
	WHERE	PositionID = @PositionID
	AND		@@ROWCOUNT > 0

GO
