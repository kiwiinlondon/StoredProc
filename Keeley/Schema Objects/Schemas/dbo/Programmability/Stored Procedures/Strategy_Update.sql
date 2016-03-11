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
		@StrategyId int, 
		@Name varchar(100), 
		@FMCode varchar(5), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Strategy_hst (
			StrategyId, Name, FMCode, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	StrategyId, Name, FMCode, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	Strategy
	WHERE	StrategyId = @StrategyId

	UPDATE	Strategy
	SET		Name = @Name, FMCode = @FMCode, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	StrategyId = @StrategyId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Strategy
	WHERE	StrategyId = @StrategyId
	AND		@@ROWCOUNT > 0

GO
