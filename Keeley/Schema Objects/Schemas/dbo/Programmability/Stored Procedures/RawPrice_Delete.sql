USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RawPrice_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RawPrice_Delete]
GO

CREATE PROCEDURE DBO.[RawPrice_Delete]
		@RawPriceId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO RawPrice_hst (
			RawPriceId, InstrumentMarketId, ReferenceDate, EntityRankingSchemeItemId, BidValue, BidUpdateDate, AskValue, AskUpdateDate, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	RawPriceId, InstrumentMarketId, ReferenceDate, EntityRankingSchemeItemId, BidValue, BidUpdateDate, AskValue, AskUpdateDate, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	RawPrice
	WHERE	RawPriceId = @RawPriceId

	DELETE	RawPrice
	WHERE	RawPriceId = @RawPriceId
	AND		DataVersion = @DataVersion
GO
