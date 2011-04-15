USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PositionAccountMovementType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PositionAccountMovementType_Insert]
GO

CREATE PROCEDURE DBO.[PositionAccountMovementType_Insert]
		@Name varchar(50), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PositionAccountMovementType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	PositionAccountMovementTypeId, StartDt, DataVersion
	FROM	PositionAccountMovementType
	WHERE	PositionAccountMovementTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
