USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundPortfolioChangeMonitorType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundPortfolioChangeMonitorType_Insert]
GO

CREATE PROCEDURE DBO.[FundPortfolioChangeMonitorType_Insert]
		@Name varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FundPortfolioChangeMonitorType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	FundChangeMonitorTypeID, StartDt, DataVersion
	FROM	FundPortfolioChangeMonitorType
	WHERE	FundChangeMonitorTypeID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
