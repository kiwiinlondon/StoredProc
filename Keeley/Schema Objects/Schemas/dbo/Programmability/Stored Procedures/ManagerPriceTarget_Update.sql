USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ManagerPriceTarget_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ManagerPriceTarget_Update]
GO

CREATE PROCEDURE DBO.[ManagerPriceTarget_Update]
		@ManagerPriceRangeId int, 
		@ManagerId int, 
		@InstrumentMarketId int, 
		@StopLossPrice numeric(27,8), 
		@TargetPrice numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ManagerPriceTarget_hst (
			ManagerPriceRangeId, ManagerId, InstrumentMarketId, StopLossPrice, TargetPrice, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ManagerPriceRangeId, ManagerId, InstrumentMarketId, StopLossPrice, TargetPrice, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ManagerPriceTarget
	WHERE	ManagerPriceRangeId = @ManagerPriceRangeId

	UPDATE	ManagerPriceTarget
	SET		ManagerId = @ManagerId, InstrumentMarketId = @InstrumentMarketId, StopLossPrice = @StopLossPrice, TargetPrice = @TargetPrice, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ManagerPriceRangeId = @ManagerPriceRangeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ManagerPriceTarget
	WHERE	ManagerPriceRangeId = @ManagerPriceRangeId
	AND		@@ROWCOUNT > 0

GO
