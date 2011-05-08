USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FXRate_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FXRate_Update]
GO

CREATE PROCEDURE DBO.[FXRate_Update]
		@FXRateId int, 
		@FromCurrencyId int, 
		@ToCurrencyId int, 
		@ReferenceDate datetime, 
		@EntityRankingSchemeId int, 
		@ForwardDate datetime, 
		@RawFXRateId int, 
		@RawFXRate2Id int, 
		@Value numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FXRate_hst (
			FXRateId, FromCurrencyId, ToCurrencyId, ReferenceDate, EntityRankingSchemeId, ForwardDate, RawFXRateId, RawFXRate2Id, Value, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FXRateId, FromCurrencyId, ToCurrencyId, ReferenceDate, EntityRankingSchemeId, ForwardDate, RawFXRateId, RawFXRate2Id, Value, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	FXRate
	WHERE	FXRateId = @FXRateId

	UPDATE	FXRate
	SET		FromCurrencyId = @FromCurrencyId, ToCurrencyId = @ToCurrencyId, ReferenceDate = @ReferenceDate, EntityRankingSchemeId = @EntityRankingSchemeId, ForwardDate = @ForwardDate, RawFXRateId = @RawFXRateId, RawFXRate2Id = @RawFXRate2Id, Value = @Value, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	FXRateId = @FXRateId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FXRate
	WHERE	FXRateId = @FXRateId
	AND		@@ROWCOUNT > 0

GO
