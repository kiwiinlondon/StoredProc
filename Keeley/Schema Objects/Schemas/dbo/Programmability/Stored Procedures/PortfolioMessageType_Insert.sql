USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioMessageType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioMessageType_Insert]
GO

CREATE PROCEDURE DBO.[PortfolioMessageType_Insert]
		@Name varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PortfolioMessageType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	PortfolioMessageTypeId, StartDt, DataVersion
	FROM	PortfolioMessageType
	WHERE	PortfolioMessageTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
