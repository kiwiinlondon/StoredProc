USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioMessageType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioMessageType_Update]
GO

CREATE PROCEDURE DBO.[PortfolioMessageType_Update]
		@PortfolioMessageTypeId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PortfolioMessageType_hst (
			PortfolioMessageTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PortfolioMessageTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	PortfolioMessageType
	WHERE	PortfolioMessageTypeId = @PortfolioMessageTypeId

	UPDATE	PortfolioMessageType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	PortfolioMessageTypeId = @PortfolioMessageTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PortfolioMessageType
	WHERE	PortfolioMessageTypeId = @PortfolioMessageTypeId
	AND		@@ROWCOUNT > 0

GO
