USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ManagerPriceTarget_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ManagerPriceTarget_Delete]
GO

CREATE PROCEDURE DBO.[ManagerPriceTarget_Delete]
		@ManagerPriceRangeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ManagerPriceTarget_hst (
			ManagerPriceRangeId, ManagerId, InstrumentMarketId, StopLossPrice, TargetPrice, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ManagerPriceRangeId, ManagerId, InstrumentMarketId, StopLossPrice, TargetPrice, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ManagerPriceTarget
	WHERE	ManagerPriceRangeId = @ManagerPriceRangeId

	DELETE	ManagerPriceTarget
	WHERE	ManagerPriceRangeId = @ManagerPriceRangeId
	AND		DataVersion = @DataVersion
GO
