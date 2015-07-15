USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClosedPosition_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClosedPosition_Insert]
GO

CREATE PROCEDURE DBO.[ClosedPosition_Insert]
		@PositionId int, 
		@ReferenceDate datetime, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ClosedPosition
			(PositionId, ReferenceDate, UpdateUserID, StartDt)
	VALUES
			(@PositionId, @ReferenceDate, @UpdateUserID, @StartDt)

	SELECT	ClosedPositionID, StartDt, DataVersion
	FROM	ClosedPosition
	WHERE	ClosedPositionID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
