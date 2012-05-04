USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ChargeSchedule_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ChargeSchedule_Insert]
GO

CREATE PROCEDURE DBO.[ChargeSchedule_Insert]
		@InstrumentClassId int, 
		@Name varchar(100), 
		@ChargeTypeId int, 
		@IssuerId int, 
		@CurrencyId int, 
		@ApplyToQuantity bit, 
		@PercentageToApply numeric(27,8), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ChargeSchedule
			(InstrumentClassId, Name, ChargeTypeId, IssuerId, CurrencyId, ApplyToQuantity, PercentageToApply, UpdateUserID, StartDt)
	VALUES
			(@InstrumentClassId, @Name, @ChargeTypeId, @IssuerId, @CurrencyId, @ApplyToQuantity, @PercentageToApply, @UpdateUserID, @StartDt)

	SELECT	ChargeScheduleId, StartDt, DataVersion
	FROM	ChargeSchedule
	WHERE	ChargeScheduleId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
