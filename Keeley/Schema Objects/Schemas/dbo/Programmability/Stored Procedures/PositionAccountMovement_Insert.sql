USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PositionAccountMovement_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PositionAccountMovement_Insert]
GO

CREATE PROCEDURE DBO.[PositionAccountMovement_Insert]
		@InternalAllocationID int, 
		@PositionAccountID int, 
		@Quantity numeric(27,8), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PositionAccountMovement
			(InternalAllocationID, PositionAccountID, Quantity, UpdateUserID, StartDt)
	VALUES
			(@InternalAllocationID, @PositionAccountID, @Quantity, @UpdateUserID, @StartDt)

	SELECT	PositionAccountMovementID, StartDt, DataVersion
	FROM	PositionAccountMovement
	WHERE	PositionAccountMovementID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
