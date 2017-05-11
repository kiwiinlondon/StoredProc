USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundPortfolioChange_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundPortfolioChange_Delete]
GO

CREATE PROCEDURE DBO.[FundPortfolioChange_Delete]
		@FundPortfolioChangeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FundPortfolioChange_hst (
			FundPortfolioChangeId, FundId, FundPortfolioChangeTypeId, ReferenceDate, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FundPortfolioChangeId, FundId, FundPortfolioChangeTypeId, ReferenceDate, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	FundPortfolioChange
	WHERE	FundPortfolioChangeId = @FundPortfolioChangeId

	DELETE	FundPortfolioChange
	WHERE	FundPortfolioChangeId = @FundPortfolioChangeId
	AND		DataVersion = @DataVersion
GO
