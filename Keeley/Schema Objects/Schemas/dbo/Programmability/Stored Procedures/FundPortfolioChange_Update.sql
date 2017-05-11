USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundPortfolioChange_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundPortfolioChange_Update]
GO

CREATE PROCEDURE DBO.[FundPortfolioChange_Update]
		@FundPortfolioChangeId int, 
		@FundId int, 
		@FundPortfolioChangeTypeId int, 
		@ReferenceDate datetime, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FundPortfolioChange_hst (
			FundPortfolioChangeId, FundId, FundPortfolioChangeTypeId, ReferenceDate, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FundPortfolioChangeId, FundId, FundPortfolioChangeTypeId, ReferenceDate, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	FundPortfolioChange
	WHERE	FundPortfolioChangeId = @FundPortfolioChangeId

	UPDATE	FundPortfolioChange
	SET		FundId = @FundId, FundPortfolioChangeTypeId = @FundPortfolioChangeTypeId, ReferenceDate = @ReferenceDate, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	FundPortfolioChangeId = @FundPortfolioChangeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FundPortfolioChange
	WHERE	FundPortfolioChangeId = @FundPortfolioChangeId
	AND		@@ROWCOUNT > 0

GO
