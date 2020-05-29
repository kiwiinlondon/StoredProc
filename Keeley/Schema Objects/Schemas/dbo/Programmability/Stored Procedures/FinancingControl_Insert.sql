USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FinancingControl_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FinancingControl_Insert]
GO

CREATE PROCEDURE DBO.[FinancingControl_Insert]
		@FundId int, 
		@ReferenceDate datetime, 
		@Loaded bit, 
		@UpdateUserID int, 
		@CustodianId int, 
		@FinancingTypeId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FinancingControl
			(FundId, ReferenceDate, Loaded, UpdateUserID, CustodianId, FinancingTypeId, StartDt)
	VALUES
			(@FundId, @ReferenceDate, @Loaded, @UpdateUserID, @CustodianId, @FinancingTypeId, @StartDt)

	SELECT	FinancingControlId, StartDt, DataVersion
	FROM	FinancingControl
	WHERE	FinancingControlId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
