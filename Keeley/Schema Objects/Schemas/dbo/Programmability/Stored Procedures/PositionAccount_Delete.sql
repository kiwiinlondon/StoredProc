USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PositionAccount_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PositionAccount_Delete]
GO

CREATE PROCEDURE DBO.[PositionAccount_Delete]
		@PositionAccountID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PositionAccount_hst (
			PositionAccountID, AccountID, PositionId, StartDt, UpdateUserID, DataVersion, BookID, InstrumentMarketID, CurrencyID, EndDt, LastActionUserID)
	SELECT	PositionAccountID, AccountID, PositionId, StartDt, UpdateUserID, DataVersion, BookID, InstrumentMarketID, CurrencyID, @EndDt, @UpdateUserID
	FROM	PositionAccount
	WHERE	PositionAccountID = @PositionAccountID

	DELETE	PositionAccount
	WHERE	PositionAccountID = @PositionAccountID
	AND		DataVersion = @DataVersion
GO
