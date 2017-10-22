USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AttributionPosition_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AttributionPosition_Update]
GO

CREATE PROCEDURE DBO.[AttributionPosition_Update]
		@AttributionPositionId int, 
		@PositionId int, 
		@ReferenceDate datetime, 
		@OpenWeight numeric(16,8), 
		@PriceReturn numeric(16,8), 
		@FxReturn numeric(16,8), 
		@UpdateUserId int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO AttributionPosition_hst (
			AttributionPositionId, PositionId, ReferenceDate, OpenWeight, PriceReturn, FxReturn, StartDt, UpdateUserId, DataVersion, EndDt, LastActionUserID)
	SELECT	AttributionPositionId, PositionId, ReferenceDate, OpenWeight, PriceReturn, FxReturn, StartDt, UpdateUserId, DataVersion, @StartDt, @UpdateUserID
	FROM	AttributionPosition
	WHERE	AttributionPositionId = @AttributionPositionId

	UPDATE	AttributionPosition
	SET		PositionId = @PositionId, ReferenceDate = @ReferenceDate, OpenWeight = @OpenWeight, PriceReturn = @PriceReturn, FxReturn = @FxReturn, UpdateUserId = @UpdateUserId,  StartDt = @StartDt
	WHERE	AttributionPositionId = @AttributionPositionId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	AttributionPosition
	WHERE	AttributionPositionId = @AttributionPositionId
	AND		@@ROWCOUNT > 0

GO
