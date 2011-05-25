USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RawPrice_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RawPrice_Insert]
GO

CREATE PROCEDURE DBO.[RawPrice_Insert]
		@InstrumentMarketId int, 
		@ReferenceDate datetime, 
		@EntityRankingSchemeItemId int, 
		@BidValue numeric(27,8), 
		@BidUpdateDate datetime, 
		@AskValue numeric(27,8), 
		@AskUpdateDate datetime, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into RawPrice
			(InstrumentMarketId, ReferenceDate, EntityRankingSchemeItemId, BidValue, BidUpdateDate, AskValue, AskUpdateDate, UpdateUserID, StartDt)
	VALUES
			(@InstrumentMarketId, @ReferenceDate, @EntityRankingSchemeItemId, @BidValue, @BidUpdateDate, @AskValue, @AskUpdateDate, @UpdateUserID, @StartDt)

	SELECT	RawPriceId, StartDt, DataVersion
	FROM	RawPrice
	WHERE	RawPriceId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
