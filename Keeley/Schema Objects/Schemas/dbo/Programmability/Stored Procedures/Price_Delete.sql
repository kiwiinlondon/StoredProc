USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Price_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Price_Delete]
GO

CREATE PROCEDURE DBO.[Price_Delete]
		@PriceId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Price_hst (
			PriceId, InstrumentMarketId, ReferenceDate, EntityRankingSchemeId, RawPriceId, Value, StartDt, UpdateUserID, DataVersion, EntityRankingSchemeItemId, EndDt, LastActionUserID)
	SELECT	PriceId, InstrumentMarketId, ReferenceDate, EntityRankingSchemeId, RawPriceId, Value, StartDt, UpdateUserID, DataVersion, EntityRankingSchemeItemId, @EndDt, @UpdateUserID
	FROM	Price
	WHERE	PriceId = @PriceId

	DELETE	Price
	WHERE	PriceId = @PriceId
	AND		DataVersion = @DataVersion
GO
