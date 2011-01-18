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
		@StrategyID timestamp,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Strategy_hst (
			StrategyID, FMStrategy, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	StrategyID, FMStrategy, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	Strategy
	WHERE	StrategyID = @StrategyID

	DELETE	Strategy
	WHERE	StrategyID = @StrategyID
	AND		DataVersion = @DataVersion
GO
