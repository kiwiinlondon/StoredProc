USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioEventType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioEventType_Insert]
GO

CREATE PROCEDURE DBO.[PortfolioEventType_Insert]
		@Name varchar(50), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PortfolioEventType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	PortfolioEventTypeId, StartDt, DataVersion
	FROM	PortfolioEventType
	WHERE	PortfolioEventTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
