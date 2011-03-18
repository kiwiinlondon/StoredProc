USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PositionAccountMovement_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PositionAccountMovement_Update]
GO

CREATE PROCEDURE DBO.[PositionAccountMovement_Update]
		@PositionAccountMovementID int, 
		@InternalAllocationID int, 
		@PositionAccountID int, 
		@Quantity numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PositionAccountMovement_hst (
			PositionAccountMovementID, InternalAllocationID, PositionAccountID, Quantity, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PositionAccountMovementID, InternalAllocationID, PositionAccountID, Quantity, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	PositionAccountMovement
	WHERE	PositionAccountMovementID = @PositionAccountMovementID

	UPDATE	PositionAccountMovement
	SET		InternalAllocationID = @InternalAllocationID, PositionAccountID = @PositionAccountID, Quantity = @Quantity, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	PositionAccountMovementID = @PositionAccountMovementID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PositionAccountMovement
	WHERE	PositionAccountMovementID = @PositionAccountMovementID
	AND		@@ROWCOUNT > 0

GO
