USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[CompanySize_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[CompanySize_Delete]
GO

CREATE PROCEDURE DBO.[CompanySize_Delete]
		@CompanySizeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO CompanySize_hst (
			CompanySizeId, Name, MarketCapUSD, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	CompanySizeId, Name, MarketCapUSD, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	CompanySize
	WHERE	CompanySizeId = @CompanySizeId

	DELETE	CompanySize
	WHERE	CompanySizeId = @CompanySizeId
	AND		DataVersion = @DataVersion
GO
