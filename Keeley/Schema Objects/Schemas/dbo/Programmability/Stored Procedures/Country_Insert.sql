USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Country_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Country_Insert]
GO

CREATE PROCEDURE DBO.[Country_Insert]
		@Name varchar, 
		@IsoCode varchar, 
		@RegionID int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Country
			(Name, IsoCode, RegionID, UpdateUserID, StartDt)
	VALUES
			(@Name, @IsoCode, @RegionID, @UpdateUserID, @StartDt)

	SELECT	CountryID, StartDt, DataVersion
	FROM	Country
	WHERE	CountryID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
