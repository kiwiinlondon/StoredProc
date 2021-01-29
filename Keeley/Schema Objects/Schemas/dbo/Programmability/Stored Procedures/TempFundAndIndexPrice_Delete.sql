USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TempFundAndIndexPrice_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TempFundAndIndexPrice_Delete]
GO

CREATE PROCEDURE DBO.[TempFundAndIndexPrice_Delete]
		@PriceId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO TempFundAndIndexPrice_hst (
			PriceId, InstrumentMarketId, ReferenceDate, Value, EndDt, LastActionUserID)
	SELECT	PriceId, InstrumentMarketId, ReferenceDate, Value, @EndDt, @UpdateUserID
	FROM	TempFundAndIndexPrice
	WHERE	PriceId = @PriceId

	DELETE	TempFundAndIndexPrice
	WHERE	PriceId = @PriceId
	AND		DataVersion = @DataVersion
GO
