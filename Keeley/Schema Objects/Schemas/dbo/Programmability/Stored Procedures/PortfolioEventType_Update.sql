USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioEventType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioEventType_Update]
GO

CREATE PROCEDURE DBO.[PortfolioEventType_Update]
		@PortfolioEventTypeId int, 
		@Name varchar(50), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PortfolioEventType_hst (
			PortfolioEventTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PortfolioEventTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	PortfolioEventType
	WHERE	PortfolioEventTypeId = @PortfolioEventTypeId

	UPDATE	PortfolioEventType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	PortfolioEventTypeId = @PortfolioEventTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PortfolioEventType
	WHERE	PortfolioEventTypeId = @PortfolioEventTypeId
	AND		@@ROWCOUNT > 0

GO
