USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[LegalEntityChargeSchedule_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[LegalEntityChargeSchedule_Insert]
GO

CREATE PROCEDURE DBO.[LegalEntityChargeSchedule_Insert]
		@CounterpartyId int, 
		@CustodianId int, 
		@ChargeScheduleId int, 
		@EffectiveFromDt datetime, 
		@EffectiveToDt datetime, 
		@UpdateUserID int, 
		@CountryId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into LegalEntityChargeSchedule
			(CounterpartyId, CustodianId, ChargeScheduleId, EffectiveFromDt, EffectiveToDt, UpdateUserID, CountryId, StartDt)
	VALUES
			(@CounterpartyId, @CustodianId, @ChargeScheduleId, @EffectiveFromDt, @EffectiveToDt, @UpdateUserID, @CountryId, @StartDt)

	SELECT	LegalEntityChargeScheduleId, StartDt, DataVersion
	FROM	LegalEntityChargeSchedule
	WHERE	LegalEntityChargeScheduleId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
