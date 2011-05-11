USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RawFXRate_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RawFXRate_Delete]
GO

CREATE PROCEDURE DBO.[RawFXRate_Delete]
		@RawFXRateId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO RawFXRate_hst (
			RawFXRateId, FromCurrencyId, ToCurrencyId, ReferenceDate, ForwardDate, EntityRankingSchemeItemId, BidValue, BidUpdateDate, AskValue, AskUpdateDate, StartDt, UpdateUserID, DataVersion, RawFXRateUsedId, EndDt, LastActionUserID)
	SELECT	RawFXRateId, FromCurrencyId, ToCurrencyId, ReferenceDate, ForwardDate, EntityRankingSchemeItemId, BidValue, BidUpdateDate, AskValue, AskUpdateDate, StartDt, UpdateUserID, DataVersion, RawFXRateUsedId, @EndDt, @UpdateUserID
	FROM	RawFXRate
	WHERE	RawFXRateId = @RawFXRateId

	DELETE	RawFXRate
	WHERE	RawFXRateId = @RawFXRateId
	AND		DataVersion = @DataVersion
GO
