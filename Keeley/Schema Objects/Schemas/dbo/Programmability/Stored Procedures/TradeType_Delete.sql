USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TradeType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TradeType_Delete]
GO

CREATE PROCEDURE DBO.[TradeType_Delete]
		@TradeTypeID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO TradeType_hst (
			TradeTypeID, FMTradType, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	TradeTypeID, FMTradType, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	TradeType
	WHERE	TradeTypeID = @TradeTypeID

	DELETE	TradeType
	WHERE	TradeTypeID = @TradeTypeID
	AND		DataVersion = @DataVersion
GO
