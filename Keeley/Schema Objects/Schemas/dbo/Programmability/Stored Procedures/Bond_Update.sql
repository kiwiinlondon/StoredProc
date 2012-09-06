USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Bond_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Bond_Update]
GO

CREATE PROCEDURE DBO.[Bond_Update]
		@InstrumentId int, 
		@DayCountConventionID int, 
		@FirstCouponDate datetime, 
		@CouponFrequency int, 
		@Coupon numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@InDefault bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Bond_hst (
			InstrumentId, DayCountConventionID, FirstCouponDate, CouponFrequency, Coupon, StartDt, UpdateUserID, DataVersion, InDefault, EndDt, LastActionUserID)
	SELECT	InstrumentId, DayCountConventionID, FirstCouponDate, CouponFrequency, Coupon, StartDt, UpdateUserID, DataVersion, InDefault, @StartDt, @UpdateUserID
	FROM	Bond
	WHERE	InstrumentId = @InstrumentId

	UPDATE	Bond
	SET		DayCountConventionID = @DayCountConventionID, FirstCouponDate = @FirstCouponDate, CouponFrequency = @CouponFrequency, Coupon = @Coupon, UpdateUserID = @UpdateUserID, InDefault = @InDefault,  StartDt = @StartDt
	WHERE	InstrumentId = @InstrumentId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Bond
	WHERE	InstrumentId = @InstrumentId
	AND		@@ROWCOUNT > 0

GO
