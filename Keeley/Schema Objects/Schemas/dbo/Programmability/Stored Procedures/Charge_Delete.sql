USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Charge_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Charge_Delete]
GO

CREATE PROCEDURE DBO.[Charge_Delete]
		@ChargeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Charge_hst (
			ChargeId, InternalAllocationID, ChargeTypeId, CurrencyId, Quantity, FXRate, FXRateMultiply, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ChargeId, InternalAllocationID, ChargeTypeId, CurrencyId, Quantity, FXRate, FXRateMultiply, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	Charge
	WHERE	ChargeId = @ChargeId

	DELETE	Charge
	WHERE	ChargeId = @ChargeId
	AND		DataVersion = @DataVersion
GO
