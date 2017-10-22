USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AttributionPosition_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AttributionPosition_Delete]
GO

CREATE PROCEDURE DBO.[AttributionPosition_Delete]
		@AttributionPositionId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO AttributionPosition_hst (
			AttributionPositionId, PositionId, ReferenceDate, OpenWeight, PriceReturn, FxReturn, StartDt, UpdateUserId, DataVersion, EndDt, LastActionUserID)
	SELECT	AttributionPositionId, PositionId, ReferenceDate, OpenWeight, PriceReturn, FxReturn, StartDt, UpdateUserId, DataVersion, @EndDt, @UpdateUserID
	FROM	AttributionPosition
	WHERE	AttributionPositionId = @AttributionPositionId

	DELETE	AttributionPosition
	WHERE	AttributionPositionId = @AttributionPositionId
	AND		DataVersion = @DataVersion
GO
