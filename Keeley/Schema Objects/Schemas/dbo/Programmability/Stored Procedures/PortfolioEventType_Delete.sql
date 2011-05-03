USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioEventType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioEventType_Delete]
GO

CREATE PROCEDURE DBO.[PortfolioEventType_Delete]
		@PortfolioEventTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PortfolioEventType_hst (
			PortfolioEventTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PortfolioEventTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	PortfolioEventType
	WHERE	PortfolioEventTypeId = @PortfolioEventTypeId

	DELETE	PortfolioEventType
	WHERE	PortfolioEventTypeId = @PortfolioEventTypeId
	AND		DataVersion = @DataVersion
GO
