USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Bond_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Bond_Insert]
GO

CREATE PROCEDURE DBO.[Bond_Insert]
		@InstrumentId int, 
		@DayCountConventionID int, 
		@FirstCouponDate datetime, 
		@CouponFrequency int, 
		@Coupon numeric(27,8), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Bond
			(InstrumentId, DayCountConventionID, FirstCouponDate, CouponFrequency, Coupon, UpdateUserID, StartDt)
	VALUES
			(@InstrumentId, @DayCountConventionID, @FirstCouponDate, @CouponFrequency, @Coupon, @UpdateUserID, @StartDt)

	SELECT	InstrumentId, StartDt, DataVersion
	FROM	Bond
	WHERE	InstrumentId = @InstrumentId
	AND		@@ROWCOUNT > 0

GO
