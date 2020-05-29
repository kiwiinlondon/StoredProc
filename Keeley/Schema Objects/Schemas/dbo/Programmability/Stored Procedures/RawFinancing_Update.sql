USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RawFinancing_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RawFinancing_Update]
GO

CREATE PROCEDURE DBO.[RawFinancing_Update]
		@RawFinancingId int, 
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
		@DataVersion rowversion, 
		@FinancingControlId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO RawFinancing_hst (
			RawFinancingId, FinancingId, RawFinancingTypeId, Notional, Rate, Accrual, Units, Price, DayCount, DayBasis, StartDt, UpdateUserID, DataVersion, FinancingControlId, EndDt, LastActionUserID)
	SELECT	RawFinancingId, FinancingId, RawFinancingTypeId, Notional, Rate, Accrual, Units, Price, DayCount, DayBasis, StartDt, UpdateUserID, DataVersion, FinancingControlId, @StartDt, @UpdateUserID
	FROM	RawFinancing
	WHERE	RawFinancingId = @RawFinancingId

	UPDATE	RawFinancing
	SET		FinancingId = @FinancingId, RawFinancingTypeId = @RawFinancingTypeId, Notional = @Notional, Rate = @Rate, Accrual = @Accrual, Units = @Units, Price = @Price, DayCount = @DayCount, DayBasis = @DayBasis, UpdateUserID = @UpdateUserID, FinancingControlId = @FinancingControlId,  StartDt = @StartDt
	WHERE	RawFinancingId = @RawFinancingId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	RawFinancing
	WHERE	RawFinancingId = @RawFinancingId
	AND		@@ROWCOUNT > 0

GO
