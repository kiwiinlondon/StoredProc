USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FXRate_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FXRate_Delete]
GO

CREATE PROCEDURE DBO.[FXRate_Delete]
		@FXRateId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FXRate_hst (
			FXRateId, FromCurrencyId, ToCurrencyId, ReferenceDate, EntityRankingSchemeId, ForwardDate, Value, StartDt, UpdateUserID, DataVersion, FromRawFXRateId, ToRawFXRateId, FromSecondRawFXRateId, ToSecondRawFXRateId, EndDt, LastActionUserID)
	SELECT	FXRateId, FromCurrencyId, ToCurrencyId, ReferenceDate, EntityRankingSchemeId, ForwardDate, Value, StartDt, UpdateUserID, DataVersion, FromRawFXRateId, ToRawFXRateId, FromSecondRawFXRateId, ToSecondRawFXRateId, @EndDt, @UpdateUserID
	FROM	FXRate
	WHERE	FXRateId = @FXRateId

	DELETE	FXRate
	WHERE	FXRateId = @FXRateId
	AND		DataVersion = @DataVersion
GO
