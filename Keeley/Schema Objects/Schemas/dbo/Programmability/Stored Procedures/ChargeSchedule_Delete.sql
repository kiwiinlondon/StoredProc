USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ChargeSchedule_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ChargeSchedule_Delete]
GO

CREATE PROCEDURE DBO.[ChargeSchedule_Delete]
		@ChargeScheduleId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ChargeSchedule_hst (
			ChargeScheduleId, InstrumentClassId, Name, ChargeTypeId, IssuerId, CurrencyId, ApplyToQuantity, PercentageToApply, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ChargeScheduleId, InstrumentClassId, Name, ChargeTypeId, IssuerId, CurrencyId, ApplyToQuantity, PercentageToApply, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ChargeSchedule
	WHERE	ChargeScheduleId = @ChargeScheduleId

	DELETE	ChargeSchedule
	WHERE	ChargeScheduleId = @ChargeScheduleId
	AND		DataVersion = @DataVersion
GO
