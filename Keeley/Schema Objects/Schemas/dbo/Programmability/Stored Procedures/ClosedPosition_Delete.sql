USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClosedPosition_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClosedPosition_Delete]
GO

CREATE PROCEDURE DBO.[ClosedPosition_Delete]
		@ClosedPositionID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ClosedPosition_hst (
			ClosedPositionID, PositionId, ReferenceDate, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ClosedPositionID, PositionId, ReferenceDate, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ClosedPosition
	WHERE	ClosedPositionID = @ClosedPositionID

	DELETE	ClosedPosition
	WHERE	ClosedPositionID = @ClosedPositionID
	AND		DataVersion = @DataVersion
GO
