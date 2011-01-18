USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Country_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Country_Update]
GO

CREATE PROCEDURE DBO.[Country_Update]
		@CountryID int, 
		@Name varchar(100), 
		@IsoCode varchar(5), 
		@RegionID int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Country_hst (
			CountryID, Name, IsoCode, RegionID, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	CountryID, Name, IsoCode, RegionID, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	Country
	WHERE	CountryID = @CountryID

	UPDATE	Country
	SET		Name = @Name, IsoCode = @IsoCode, RegionID = @RegionID, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	CountryID = @CountryID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Country
	WHERE	CountryID = @CountryID
	AND		@@ROWCOUNT > 0

GO
