USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PositionWithOutAccount_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PositionWithOutAccount_Delete]
GO

CREATE PROCEDURE DBO.[PositionWithOutAccount_Delete]
		@PositionID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PositionWithOutAccount_hst (
			PositionID, BookID, InstrumentMarketID, CurrencyID, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PositionID, BookID, InstrumentMarketID, CurrencyID, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	PositionWithOutAccount
	WHERE	PositionID = @PositionID

	DELETE	PositionWithOutAccount
	WHERE	PositionID = @PositionID
	AND		DataVersion = @DataVersion
GO
