USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Strategy_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Strategy_Update]

GO
CREATE PROCEDURE DBO.[Strategy_Update]
		@StrategyID int, 
		@FMStrategy varchar, 
		@Name varchar, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Strategy_hst (
			StrategyID, FMStrategy, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	StrategyID, FMStrategy, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	Strategy
	WHERE	StrategyID = StrategyID

	UPDATE	Strategy
	SET		FMStrategy = @FMStrategy, Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	StrategyID = @StrategyID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Strategy
	WHERE	StrategyID = @StrategyID
	AND		@@ROWCOUNT > 0

GO
