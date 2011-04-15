USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PositionAccountMovementType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PositionAccountMovementType_Delete]
GO

CREATE PROCEDURE DBO.[PositionAccountMovementType_Delete]
		@PositionAccountMovementTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PositionAccountMovementType_hst (
			PositionAccountMovementTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PositionAccountMovementTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	PositionAccountMovementType
	WHERE	PositionAccountMovementTypeId = @PositionAccountMovementTypeId

	DELETE	PositionAccountMovementType
	WHERE	PositionAccountMovementTypeId = @PositionAccountMovementTypeId
	AND		DataVersion = @DataVersion
GO
