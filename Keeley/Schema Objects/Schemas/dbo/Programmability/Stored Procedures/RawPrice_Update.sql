USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RawPrice_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RawPrice_Update]
GO

CREATE PROCEDURE DBO.[RawPrice_Update]
		@RawPriceId int, 
		@InstrumentMarketId int, 
		@ReferenceDate datetime, 
		@EntityRankingSchemeItemId int, 
		@BidValue numeric(27,8), 
		@BidUpdateDate datetime, 
		@AskValue numeric(27,8), 
		@AskUpdateDate datetime, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@RawPriceUsedId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO RawPrice_hst (
			RawPriceId, InstrumentMarketId, ReferenceDate, EntityRankingSchemeItemId, BidValue, BidUpdateDate, AskValue, AskUpdateDate, StartDt, UpdateUserID, DataVersion, RawPriceUsedId, EndDt, LastActionUserID)
	SELECT	RawPriceId, InstrumentMarketId, ReferenceDate, EntityRankingSchemeItemId, BidValue, BidUpdateDate, AskValue, AskUpdateDate, StartDt, UpdateUserID, DataVersion, RawPriceUsedId, @StartDt, @UpdateUserID
	FROM	RawPrice
	WHERE	RawPriceId = @RawPriceId

	UPDATE	RawPrice
	SET		InstrumentMarketId = @InstrumentMarketId, ReferenceDate = @ReferenceDate, EntityRankingSchemeItemId = @EntityRankingSchemeItemId, BidValue = @BidValue, BidUpdateDate = @BidUpdateDate, AskValue = @AskValue, AskUpdateDate = @AskUpdateDate, UpdateUserID = @UpdateUserID, RawPriceUsedId = @RawPriceUsedId,  StartDt = @StartDt
	WHERE	RawPriceId = @RawPriceId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	RawPrice
	WHERE	RawPriceId = @RawPriceId
	AND		@@ROWCOUNT > 0

GO
