USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TradeType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TradeType_Update]

GO
CREATE PROCEDURE DBO.[TradeType_Update]
		@TradeTypeID int, 
		@FMTradType varchar, 
		@Name varchar, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO TradeType_hst (
			TradeTypeID, FMTradType, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	TradeTypeID, FMTradType, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	TradeType
	WHERE	TradeTypeID = TradeTypeID

	UPDATE	TradeType
	SET		FMTradType = @FMTradType, Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	TradeTypeID = @TradeTypeID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	TradeType
	WHERE	TradeTypeID = @TradeTypeID
	AND		@@ROWCOUNT > 0

GO
