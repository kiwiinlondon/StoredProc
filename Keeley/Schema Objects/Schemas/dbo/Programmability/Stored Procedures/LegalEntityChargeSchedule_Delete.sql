USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[LegalEntityChargeSchedule_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[LegalEntityChargeSchedule_Delete]
GO

CREATE PROCEDURE DBO.[LegalEntityChargeSchedule_Delete]
		@LegalEntityChargeScheduleId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO LegalEntityChargeSchedule_hst (
			LegalEntityChargeScheduleId, CounterpartyId, CustodianId, ChargeScheduleId, EffectiveFromDt, EffectiveToDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	LegalEntityChargeScheduleId, CounterpartyId, CustodianId, ChargeScheduleId, EffectiveFromDt, EffectiveToDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	LegalEntityChargeSchedule
	WHERE	LegalEntityChargeScheduleId = @LegalEntityChargeScheduleId

	DELETE	LegalEntityChargeSchedule
	WHERE	LegalEntityChargeScheduleId = @LegalEntityChargeScheduleId
	AND		DataVersion = @DataVersion
GO
