USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClosedPosition_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClosedPosition_Update]
GO

CREATE PROCEDURE DBO.[ClosedPosition_Update]
		@ClosedPositionID int, 
		@PositionId int, 
		@ReferenceDate datetime, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ClosedPosition_hst (
			ClosedPositionID, PositionId, ReferenceDate, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ClosedPositionID, PositionId, ReferenceDate, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ClosedPosition
	WHERE	ClosedPositionID = @ClosedPositionID

	UPDATE	ClosedPosition
	SET		PositionId = @PositionId, ReferenceDate = @ReferenceDate, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ClosedPositionID = @ClosedPositionID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ClosedPosition
	WHERE	ClosedPositionID = @ClosedPositionID
	AND		@@ROWCOUNT > 0

GO
