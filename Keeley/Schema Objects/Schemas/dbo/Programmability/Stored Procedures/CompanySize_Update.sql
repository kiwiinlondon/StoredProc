USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[CompanySize_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[CompanySize_Update]
GO

CREATE PROCEDURE DBO.[CompanySize_Update]
		@CompanySizeId int, 
		@Name varchar(100), 
		@MarketCapUSD numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO CompanySize_hst (
			CompanySizeId, Name, MarketCapUSD, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	CompanySizeId, Name, MarketCapUSD, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	CompanySize
	WHERE	CompanySizeId = @CompanySizeId

	UPDATE	CompanySize
	SET		Name = @Name, MarketCapUSD = @MarketCapUSD, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	CompanySizeId = @CompanySizeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	CompanySize
	WHERE	CompanySizeId = @CompanySizeId
	AND		@@ROWCOUNT > 0

GO
