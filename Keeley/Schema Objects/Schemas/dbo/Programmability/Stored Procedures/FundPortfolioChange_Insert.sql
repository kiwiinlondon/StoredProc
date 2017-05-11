USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundPortfolioChange_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundPortfolioChange_Insert]
GO

CREATE PROCEDURE DBO.[FundPortfolioChange_Insert]
		@FundId int, 
		@FundPortfolioChangeTypeId int, 
		@ReferenceDate datetime, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FundPortfolioChange
			(FundId, FundPortfolioChangeTypeId, ReferenceDate, UpdateUserID, StartDt)
	VALUES
			(@FundId, @FundPortfolioChangeTypeId, @ReferenceDate, @UpdateUserID, @StartDt)

	SELECT	FundPortfolioChangeId, StartDt, DataVersion
	FROM	FundPortfolioChange
	WHERE	FundPortfolioChangeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
