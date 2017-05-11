USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundPortfolioChangeType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundPortfolioChangeType_Delete]
GO

CREATE PROCEDURE DBO.[FundPortfolioChangeType_Delete]
		@FundPortfolioChangeTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FundPortfolioChangeType_hst (
			FundPortfolioChangeTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FundPortfolioChangeTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	FundPortfolioChangeType
	WHERE	FundPortfolioChangeTypeId = @FundPortfolioChangeTypeId

	DELETE	FundPortfolioChangeType
	WHERE	FundPortfolioChangeTypeId = @FundPortfolioChangeTypeId
	AND		DataVersion = @DataVersion
GO
