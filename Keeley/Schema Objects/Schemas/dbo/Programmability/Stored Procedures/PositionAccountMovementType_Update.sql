USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PositionAccountMovementType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PositionAccountMovementType_Update]
GO

CREATE PROCEDURE DBO.[PositionAccountMovementType_Update]
		@PositionAccountMovementTypeId int, 
		@Name varchar(50), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PositionAccountMovementType_hst (
			PositionAccountMovementTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PositionAccountMovementTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	PositionAccountMovementType
	WHERE	PositionAccountMovementTypeId = @PositionAccountMovementTypeId

	UPDATE	PositionAccountMovementType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	PositionAccountMovementTypeId = @PositionAccountMovementTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PositionAccountMovementType
	WHERE	PositionAccountMovementTypeId = @PositionAccountMovementTypeId
	AND		@@ROWCOUNT > 0

GO
