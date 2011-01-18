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
		@FMStrategy varchar(15), 
		@Name varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Strategy
			(FMStrategy, Name, UpdateUserID, StartDt)
	VALUES
			(@FMStrategy, @Name, @UpdateUserID, @StartDt)

	SELECT	StrategyID, StartDt, DataVersion
	FROM	Strategy
	WHERE	StrategyID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
