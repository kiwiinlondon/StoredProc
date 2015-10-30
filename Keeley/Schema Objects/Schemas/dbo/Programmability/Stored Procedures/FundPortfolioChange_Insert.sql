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
		@ReferenceDate datetime, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FundPortfolioChange
			(FundId, ReferenceDate, UpdateUserID, StartDt)
	VALUES
			(@FundId, @ReferenceDate, @UpdateUserID, @StartDt)

	SELECT	FundPortfolioChangeID, StartDt, DataVersion
	FROM	FundPortfolioChange
	WHERE	FundPortfolioChangeID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
