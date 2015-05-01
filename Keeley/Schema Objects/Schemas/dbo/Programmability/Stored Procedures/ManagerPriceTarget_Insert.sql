USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ManagerPriceTarget_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ManagerPriceTarget_Insert]
GO

CREATE PROCEDURE DBO.[ManagerPriceTarget_Insert]
		@ManagerId int, 
		@InstrumentMarketId int, 
		@StopLossPrice numeric(27,8), 
		@TargetPrice numeric(27,8), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ManagerPriceTarget
			(ManagerId, InstrumentMarketId, StopLossPrice, TargetPrice, UpdateUserID, StartDt)
	VALUES
			(@ManagerId, @InstrumentMarketId, @StopLossPrice, @TargetPrice, @UpdateUserID, @StartDt)

	SELECT	ManagerPriceRangeId, StartDt, DataVersion
	FROM	ManagerPriceTarget
	WHERE	ManagerPriceRangeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
