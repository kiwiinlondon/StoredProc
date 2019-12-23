USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RollConvention_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RollConvention_Insert]
GO

CREATE PROCEDURE DBO.[RollConvention_Insert]
		@Name varchar(50), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into RollConvention
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	RollConventionId, StartDt, DataVersion
	FROM	RollConvention
	WHERE	RollConventionId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
