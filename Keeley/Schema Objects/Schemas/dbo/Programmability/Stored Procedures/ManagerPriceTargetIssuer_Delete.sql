USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ManagerPriceTargetIssuer_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ManagerPriceTargetIssuer_Delete]
GO

CREATE PROCEDURE DBO.[ManagerPriceTargetIssuer_Delete]
		@ManagerPriceTargetIssuerId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ManagerPriceTargetIssuer_hst (
			ManagerPriceTargetIssuerId, ManagerId, IssuerId, StopLossPrice, TargetPrice, StartDt, UpdateUserID, DataVersion, StopLossContraToEurRate, StopLossBaseToEurRate, TargetContraToEurRate, TargetBaseToEurRate, EndDt, LastActionUserID)
	SELECT	ManagerPriceTargetIssuerId, ManagerId, IssuerId, StopLossPrice, TargetPrice, StartDt, UpdateUserID, DataVersion, StopLossContraToEurRate, StopLossBaseToEurRate, TargetContraToEurRate, TargetBaseToEurRate, @EndDt, @UpdateUserID
	FROM	ManagerPriceTargetIssuer
	WHERE	ManagerPriceTargetIssuerId = @ManagerPriceTargetIssuerId

	DELETE	ManagerPriceTargetIssuer
	WHERE	ManagerPriceTargetIssuerId = @ManagerPriceTargetIssuerId
	AND		DataVersion = @DataVersion
GO
