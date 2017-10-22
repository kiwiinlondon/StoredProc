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
		@Name varchar(100), 
		@IsoCode varchar(5), 
		@RegionID int, 
		@UpdateUserID int, 
		@IsEEA bit, 
		@IsOECD bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Country
			(Name, IsoCode, RegionID, UpdateUserID, IsEEA, IsOECD, StartDt)
	VALUES
			(@Name, @IsoCode, @RegionID, @UpdateUserID, @IsEEA, @IsOECD, @StartDt)

	SELECT	CountryID, StartDt, DataVersion
	FROM	Country
	WHERE	CountryID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
