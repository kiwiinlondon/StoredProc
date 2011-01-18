USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TradeType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TradeType_Insert]
GO

CREATE PROCEDURE DBO.[TradeType_Insert]
		@FMTradType varchar, 
		@Name varchar, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into TradeType
			(FMTradType, Name, UpdateUserID, StartDt)
	VALUES
			(@FMTradType, @Name, @UpdateUserID, @StartDt)

	SELECT	TradeTypeID, StartDt, DataVersion
	FROM	TradeType
	WHERE	TradeTypeID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
