USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ChargeSchedule_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ChargeSchedule_Update]
GO

CREATE PROCEDURE DBO.[ChargeSchedule_Update]
		@ChargeScheduleId int, 
		@InstrumentClassId int, 
		@Name varchar(100), 
		@ChargeTypeId int, 
		@IssuerId int, 
		@CurrencyId int, 
		@ApplyToQuantity bit, 
		@PercentageToApply numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ChargeSchedule_hst (
			ChargeScheduleId, InstrumentClassId, Name, ChargeTypeId, IssuerId, CurrencyId, ApplyToQuantity, PercentageToApply, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ChargeScheduleId, InstrumentClassId, Name, ChargeTypeId, IssuerId, CurrencyId, ApplyToQuantity, PercentageToApply, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ChargeSchedule
	WHERE	ChargeScheduleId = @ChargeScheduleId

	UPDATE	ChargeSchedule
	SET		InstrumentClassId = @InstrumentClassId, Name = @Name, ChargeTypeId = @ChargeTypeId, IssuerId = @IssuerId, CurrencyId = @CurrencyId, ApplyToQuantity = @ApplyToQuantity, PercentageToApply = @PercentageToApply, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ChargeScheduleId = @ChargeScheduleId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ChargeSchedule
	WHERE	ChargeScheduleId = @ChargeScheduleId
	AND		@@ROWCOUNT > 0

GO
