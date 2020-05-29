USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RawFinancing_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RawFinancing_Insert]
GO

CREATE PROCEDURE DBO.[RawFinancing_Insert]
		@FinancingId int, 
		@RawFinancingTypeId int, 
		@Notional numeric(27,8), 
		@Rate numeric(27,8), 
		@Accrual numeric(27,8), 
		@Units numeric(27,8), 
		@Price numeric(27,8), 
		@DayCount int, 
		@DayBasis int, 
		@UpdateUserID int, 
		@FinancingControlId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into RawFinancing
			(FinancingId, RawFinancingTypeId, Notional, Rate, Accrual, Units, Price, DayCount, DayBasis, UpdateUserID, FinancingControlId, StartDt)
	VALUES
			(@FinancingId, @RawFinancingTypeId, @Notional, @Rate, @Accrual, @Units, @Price, @DayCount, @DayBasis, @UpdateUserID, @FinancingControlId, @StartDt)

	SELECT	RawFinancingId, StartDt, DataVersion
	FROM	RawFinancing
	WHERE	RawFinancingId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
