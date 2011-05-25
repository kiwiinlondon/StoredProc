USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Price_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Price_Insert]
GO

CREATE PROCEDURE DBO.[Price_Insert]
		@InstrumentMarketId int, 
		@ReferenceDate datetime, 
		@EntityRankingSchemeId int, 
		@RawPriceId int, 
		@Value numeric(27,8), 
		@UpdateUserID int, 
		@EntityRankingSchemeItemId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Price
			(InstrumentMarketId, ReferenceDate, EntityRankingSchemeId, RawPriceId, Value, UpdateUserID, EntityRankingSchemeItemId, StartDt)
	VALUES
			(@InstrumentMarketId, @ReferenceDate, @EntityRankingSchemeId, @RawPriceId, @Value, @UpdateUserID, @EntityRankingSchemeItemId, @StartDt)

	SELECT	PriceId, StartDt, DataVersion
	FROM	Price
	WHERE	PriceId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
