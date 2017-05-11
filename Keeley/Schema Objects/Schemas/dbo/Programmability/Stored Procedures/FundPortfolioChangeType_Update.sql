USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundPortfolioChangeType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundPortfolioChangeType_Update]
GO

CREATE PROCEDURE DBO.[FundPortfolioChangeType_Update]
		@FundPortfolioChangeTypeId int, 
		@Name varchar(50), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FundPortfolioChangeType_hst (
			FundPortfolioChangeTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FundPortfolioChangeTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	FundPortfolioChangeType
	WHERE	FundPortfolioChangeTypeId = @FundPortfolioChangeTypeId

	UPDATE	FundPortfolioChangeType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	FundPortfolioChangeTypeId = @FundPortfolioChangeTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FundPortfolioChangeType
	WHERE	FundPortfolioChangeTypeId = @FundPortfolioChangeTypeId
	AND		@@ROWCOUNT > 0

GO
