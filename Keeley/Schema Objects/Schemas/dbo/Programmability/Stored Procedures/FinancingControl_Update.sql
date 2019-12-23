USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FinancingControl_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FinancingControl_Update]
GO

CREATE PROCEDURE DBO.[FinancingControl_Update]
		@FinancingControlId int, 
		@FundId int, 
		@ReferenceDate datetime, 
		@InstrumentClassId int, 
		@Loaded bit, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@CustodianId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FinancingControl_hst (
			FinancingControlId, FundId, ReferenceDate, InstrumentClassId, Loaded, StartDt, UpdateUserID, DataVersion, CustodianId, EndDt, LastActionUserID)
	SELECT	FinancingControlId, FundId, ReferenceDate, InstrumentClassId, Loaded, StartDt, UpdateUserID, DataVersion, CustodianId, @StartDt, @UpdateUserID
	FROM	FinancingControl
	WHERE	FinancingControlId = @FinancingControlId

	UPDATE	FinancingControl
	SET		FundId = @FundId, ReferenceDate = @ReferenceDate, InstrumentClassId = @InstrumentClassId, Loaded = @Loaded, UpdateUserID = @UpdateUserID, CustodianId = @CustodianId,  StartDt = @StartDt
	WHERE	FinancingControlId = @FinancingControlId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FinancingControl
	WHERE	FinancingControlId = @FinancingControlId
	AND		@@ROWCOUNT > 0

GO
