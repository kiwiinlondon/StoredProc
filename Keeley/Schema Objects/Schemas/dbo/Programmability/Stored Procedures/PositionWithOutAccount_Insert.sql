USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PositionWithOutAccount_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PositionWithOutAccount_Insert]
GO

CREATE PROCEDURE DBO.[PositionWithOutAccount_Insert]
		@BookID int, 
		@InstrumentMarketID int, 
		@CurrencyID int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PositionWithOutAccount
			(BookID, InstrumentMarketID, CurrencyID, UpdateUserID, StartDt)
	VALUES
			(@BookID, @InstrumentMarketID, @CurrencyID, @UpdateUserID, @StartDt)

	SELECT	PositionID, StartDt, DataVersion
	FROM	PositionWithOutAccount
	WHERE	PositionID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
