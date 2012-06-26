USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[LegalEntityChargeSchedule_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[LegalEntityChargeSchedule_Update]
GO

CREATE PROCEDURE DBO.[LegalEntityChargeSchedule_Update]
		@LegalEntityChargeScheduleId int, 
		@CounterpartyId int, 
		@CustodianId int, 
		@ChargeScheduleId int, 
		@EffectiveFromDt datetime, 
		@EffectiveToDt datetime, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@CountryId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO LegalEntityChargeSchedule_hst (
			LegalEntityChargeScheduleId, CounterpartyId, CustodianId, ChargeScheduleId, EffectiveFromDt, EffectiveToDt, UpdateUserID, DataVersion, CountryId, EndDt, LastActionUserID)
	SELECT	LegalEntityChargeScheduleId, CounterpartyId, CustodianId, ChargeScheduleId, EffectiveFromDt, EffectiveToDt, UpdateUserID, DataVersion, CountryId, @StartDt, @UpdateUserID
	FROM	LegalEntityChargeSchedule
	WHERE	LegalEntityChargeScheduleId = @LegalEntityChargeScheduleId

	UPDATE	LegalEntityChargeSchedule
	SET		CounterpartyId = @CounterpartyId, CustodianId = @CustodianId, ChargeScheduleId = @ChargeScheduleId, EffectiveFromDt = @EffectiveFromDt, EffectiveToDt = @EffectiveToDt, UpdateUserID = @UpdateUserID, CountryId = @CountryId,  StartDt = @StartDt
	WHERE	LegalEntityChargeScheduleId = @LegalEntityChargeScheduleId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	LegalEntityChargeSchedule
	WHERE	LegalEntityChargeScheduleId = @LegalEntityChargeScheduleId
	AND		@@ROWCOUNT > 0

GO
