USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AttributionPosition_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AttributionPosition_Insert]
GO

CREATE PROCEDURE DBO.[AttributionPosition_Insert]
		@PositionId int, 
		@ReferenceDate datetime, 
		@OpenWeight numeric(16,8), 
		@PriceReturn numeric(16,8), 
		@FxReturn numeric(16,8), 
		@UpdateUserId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into AttributionPosition
			(PositionId, ReferenceDate, OpenWeight, PriceReturn, FxReturn, UpdateUserId, StartDt)
	VALUES
			(@PositionId, @ReferenceDate, @OpenWeight, @PriceReturn, @FxReturn, @UpdateUserId, @StartDt)

	SELECT	AttributionPositionId, StartDt, DataVersion
	FROM	AttributionPosition
	WHERE	AttributionPositionId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
