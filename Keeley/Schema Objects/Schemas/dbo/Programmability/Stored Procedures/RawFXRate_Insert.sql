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
		@CurrencyId int, 
		@ReferenceDate datetime, 
		@ForwardDate datetime, 
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

	INSERT into RawFXRate
			(CurrencyId, ReferenceDate, ForwardDate, EntityRankingSchemeItemId, BidValue, BidUpdateDate, AskValue, AskUpdateDate, UpdateUserID, StartDt)
	VALUES
			(@CurrencyId, @ReferenceDate, @ForwardDate, @EntityRankingSchemeItemId, @BidValue, @BidUpdateDate, @AskValue, @AskUpdateDate, @UpdateUserID, @StartDt)

	SELECT	RawFXRateId, StartDt, DataVersion
	FROM	RawFXRate
	WHERE	RawFXRateId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
