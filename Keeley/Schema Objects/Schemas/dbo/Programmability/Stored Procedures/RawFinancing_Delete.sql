USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RawFinancing_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RawFinancing_Delete]
GO

CREATE PROCEDURE DBO.[RawFinancing_Delete]
		@RawFinancingId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO RawFinancing_hst (
			RawFinancingId, FinancingId, RawFinancingTypeId, Notional, Rate, Accrual, Units, Price, DayCount, DayBasis, StartDt, UpdateUserID, DataVersion, FinancingControlId, EndDt, LastActionUserID)
	SELECT	RawFinancingId, FinancingId, RawFinancingTypeId, Notional, Rate, Accrual, Units, Price, DayCount, DayBasis, StartDt, UpdateUserID, DataVersion, FinancingControlId, @EndDt, @UpdateUserID
	FROM	RawFinancing
	WHERE	RawFinancingId = @RawFinancingId

	DELETE	RawFinancing
	WHERE	RawFinancingId = @RawFinancingId
	AND		DataVersion = @DataVersion
GO
