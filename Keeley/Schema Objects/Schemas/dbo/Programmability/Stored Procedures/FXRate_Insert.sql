USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FXRate_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FXRate_Insert]
GO

CREATE PROCEDURE DBO.[FXRate_Insert]
		@FromCurrencyId int, 
		@ToCurrencyId int, 
		@ReferenceDate datetime, 
		@EntityRankingSchemeId int, 
		@ForwardDate datetime, 
		@Value numeric(27,8), 
		@UpdateUserID int, 
		@FromRawFXRateId int, 
		@ToRawFXRateId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FXRate
			(FromCurrencyId, ToCurrencyId, ReferenceDate, EntityRankingSchemeId, ForwardDate, Value, UpdateUserID, FromRawFXRateId, ToRawFXRateId, StartDt)
	VALUES
			(@FromCurrencyId, @ToCurrencyId, @ReferenceDate, @EntityRankingSchemeId, @ForwardDate, @Value, @UpdateUserID, @FromRawFXRateId, @ToRawFXRateId, @StartDt)

	SELECT	FXRateId, StartDt, DataVersion
	FROM	FXRate
	WHERE	FXRateId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
