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
		@FundPortfolioChangeID int, 
		@FundId int, 
		@ReferenceDate datetime, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FundPortfolioChange_hst (
			FundPortfolioChangeID, StartDt, FundId, ReferenceDate, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FundPortfolioChangeID, StartDt, FundId, ReferenceDate, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	FundPortfolioChange
	WHERE	FundPortfolioChangeID = @FundPortfolioChangeID

	UPDATE	FundPortfolioChange
	SET		FundId = @FundId, ReferenceDate = @ReferenceDate, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	FundPortfolioChangeID = @FundPortfolioChangeID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FundPortfolioChange
	WHERE	FundPortfolioChangeID = @FundPortfolioChangeID
	AND		@@ROWCOUNT > 0

GO
