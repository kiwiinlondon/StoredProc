USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RawFXRate_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RawFXRate_Insert]
GO

CREATE PROCEDURE DBO.[RawFXRate_Insert]
		@FromCurrencyId int, 
		@ToCurrencyId int, 
		@ReferenceDate datetime, 
		@ForwardDate datetime, 
		@EntityRankingSchemeItemId int, 
		@BidValue numeric(27,8), 
		@BidUpdateDate datetime, 
		@AskValue numeric(27,8), 
		@AskUpdateDate datetime, 
		@UpdateUserID int, 
		@RawFXRateUsedId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into RawFXRate
			(FromCurrencyId, ToCurrencyId, ReferenceDate, ForwardDate, EntityRankingSchemeItemId, BidValue, BidUpdateDate, AskValue, AskUpdateDate, UpdateUserID, RawFXRateUsedId, StartDt)
	VALUES
			(@FromCurrencyId, @ToCurrencyId, @ReferenceDate, @ForwardDate, @EntityRankingSchemeItemId, @BidValue, @BidUpdateDate, @AskValue, @AskUpdateDate, @UpdateUserID, @RawFXRateUsedId, @StartDt)

	SELECT	RawFXRateId, StartDt, DataVersion
	FROM	RawFXRate
	WHERE	RawFXRateId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
