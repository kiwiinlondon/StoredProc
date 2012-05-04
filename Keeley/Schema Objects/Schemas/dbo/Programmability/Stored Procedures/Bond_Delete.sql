USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Bond_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Bond_Delete]
GO

CREATE PROCEDURE DBO.[Bond_Delete]
		@InstrumentId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Bond_hst (
			InstrumentId, DayCountConventionID, FirstCouponDate, CouponFrequency, Coupon, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	InstrumentId, DayCountConventionID, FirstCouponDate, CouponFrequency, Coupon, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	Bond
	WHERE	InstrumentId = @InstrumentId

	DELETE	Bond
	WHERE	InstrumentId = @InstrumentId
	AND		DataVersion = @DataVersion
GO
