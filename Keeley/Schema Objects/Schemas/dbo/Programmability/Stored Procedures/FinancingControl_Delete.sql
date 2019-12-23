USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FinancingControl_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FinancingControl_Delete]
GO

CREATE PROCEDURE DBO.[FinancingControl_Delete]
		@FinancingControlId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FinancingControl_hst (
			FinancingControlId, FundId, ReferenceDate, InstrumentClassId, Loaded, StartDt, UpdateUserID, DataVersion, CustodianId, EndDt, LastActionUserID)
	SELECT	FinancingControlId, FundId, ReferenceDate, InstrumentClassId, Loaded, StartDt, UpdateUserID, DataVersion, CustodianId, @EndDt, @UpdateUserID
	FROM	FinancingControl
	WHERE	FinancingControlId = @FinancingControlId

	DELETE	FinancingControl
	WHERE	FinancingControlId = @FinancingControlId
	AND		DataVersion = @DataVersion
GO
