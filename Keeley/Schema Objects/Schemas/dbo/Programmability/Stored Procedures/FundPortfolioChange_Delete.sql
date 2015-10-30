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
		@FundPortfolioChangeID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FundPortfolioChange_hst (
			FundPortfolioChangeID, StartDt, FundId, ReferenceDate, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FundPortfolioChangeID, StartDt, FundId, ReferenceDate, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	FundPortfolioChange
	WHERE	FundPortfolioChangeID = @FundPortfolioChangeID

	DELETE	FundPortfolioChange
	WHERE	FundPortfolioChangeID = @FundPortfolioChangeID
	AND		DataVersion = @DataVersion
GO
