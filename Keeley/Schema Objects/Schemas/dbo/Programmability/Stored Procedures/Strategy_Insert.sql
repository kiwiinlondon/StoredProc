USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Strategy_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Strategy_Insert]
GO

CREATE PROCEDURE DBO.[Strategy_Insert]
		@Name varchar(100), 
		@FMCode varchar(5), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Strategy
			(Name, FMCode, UpdateUserID, StartDt)
	VALUES
			(@Name, @FMCode, @UpdateUserID, @StartDt)

	SELECT	StrategyId, StartDt, DataVersion
	FROM	Strategy
	WHERE	StrategyId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
