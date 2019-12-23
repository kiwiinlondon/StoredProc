USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioMessageType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioMessageType_Delete]
GO

CREATE PROCEDURE DBO.[PortfolioMessageType_Delete]
		@PortfolioMessageTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PortfolioMessageType_hst (
			PortfolioMessageTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PortfolioMessageTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	PortfolioMessageType
	WHERE	PortfolioMessageTypeId = @PortfolioMessageTypeId

	DELETE	PortfolioMessageType
	WHERE	PortfolioMessageTypeId = @PortfolioMessageTypeId
	AND		DataVersion = @DataVersion
GO
