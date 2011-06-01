USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RawFXRate_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RawFXRate_Update]
GO

CREATE PROCEDURE DBO.[RawFXRate_Update]
		@RawFXRateId int, 
		@CurrencyId int, 
		@ReferenceDate datetime, 
		@ForwardDate datetime, 
		@EntityRankingSchemeItemId int, 
		@BidValue numeric(27,8), 
		@BidUpdateDate datetime, 
		@AskValue numeric(27,8), 
		@AskUpdateDate datetime, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO RawFXRate_hst (
			RawFXRateId, CurrencyId, ReferenceDate, ForwardDate, EntityRankingSchemeItemId, BidValue, BidUpdateDate, AskValue, AskUpdateDate, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	RawFXRateId, CurrencyId, ReferenceDate, ForwardDate, EntityRankingSchemeItemId, BidValue, BidUpdateDate, AskValue, AskUpdateDate, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	RawFXRate
	WHERE	RawFXRateId = @RawFXRateId

	UPDATE	RawFXRate
	SET		CurrencyId = @CurrencyId, ReferenceDate = @ReferenceDate, ForwardDate = @ForwardDate, EntityRankingSchemeItemId = @EntityRankingSchemeItemId, BidValue = @BidValue, BidUpdateDate = @BidUpdateDate, AskValue = @AskValue, AskUpdateDate = @AskUpdateDate, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	RawFXRateId = @RawFXRateId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	RawFXRate
	WHERE	RawFXRateId = @RawFXRateId
	AND		@@ROWCOUNT > 0

GO
