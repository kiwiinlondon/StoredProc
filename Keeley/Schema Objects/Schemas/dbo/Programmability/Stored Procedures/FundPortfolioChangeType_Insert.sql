USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundPortfolioChangeType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundPortfolioChangeType_Insert]
GO

CREATE PROCEDURE DBO.[FundPortfolioChangeType_Insert]
		@Name varchar(50), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FundPortfolioChangeType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	FundPortfolioChangeTypeId, StartDt, DataVersion
	FROM	FundPortfolioChangeType
	WHERE	FundPortfolioChangeTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
