USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Strategy_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Strategy_Delete]
GO

CREATE PROCEDURE DBO.[Strategy_Delete]
		@StrategyId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Strategy_hst (
			StrategyId, Name, FMCode, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	StrategyId, Name, FMCode, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	Strategy
	WHERE	StrategyId = @StrategyId

	DELETE	Strategy
	WHERE	StrategyId = @StrategyId
	AND		DataVersion = @DataVersion
GO
