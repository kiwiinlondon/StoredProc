USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Country_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Country_Delete]

GO
CREATE PROCEDURE DBO.[Country_Delete]
		@CountryID timestamp,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Country_hst (
			CountryID, Name, IsoCode, RegionID, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	CountryID, Name, IsoCode, RegionID, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	Country
	WHERE	CountryID = CountryID

	DELETE	Country
	WHERE	CountryID = @CountryID
	AND		DataVersion = @DataVersion
GO
