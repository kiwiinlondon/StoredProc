﻿USE Keeley

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
		@UpdateUserID int, 
		@InDefault bit, 
		@MaturityDate datetime, 
		@ParAmount numeric(27,8), 
		@IssueDate datetime, 
		@IssuePrice numeric(27,8), 
		@IsFixed bit, 
		@BondMaturityTypeId int, 
		@ConversionPrice numeric(27,8), 
		@MaturityValue numeric(27,8), 
		@IsCovered bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Bond
			(InstrumentId, DayCountConventionID, FirstCouponDate, CouponFrequency, Coupon, UpdateUserID, InDefault, MaturityDate, ParAmount, IssueDate, IssuePrice, IsFixed, BondMaturityTypeId, ConversionPrice, MaturityValue, IsCovered, StartDt)
	VALUES
			(@InstrumentId, @DayCountConventionID, @FirstCouponDate, @CouponFrequency, @Coupon, @UpdateUserID, @InDefault, @MaturityDate, @ParAmount, @IssueDate, @IssuePrice, @IsFixed, @BondMaturityTypeId, @ConversionPrice, @MaturityValue, @IsCovered, @StartDt)

	SELECT	InstrumentId, StartDt, DataVersion
	FROM	Bond
	WHERE	InstrumentId = @InstrumentId
	AND		@@ROWCOUNT > 0

GO
