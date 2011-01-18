USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Region_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Region_Insert]
GO

CREATE PROCEDURE DBO.[Region_Insert]
		@Name varchar, 
		@IsoCode varchar, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Region
			(Name, IsoCode, UpdateUserID, StartDt)
	VALUES
			(@Name, @IsoCode, @UpdateUserID, @StartDt)

	SELECT	RegionID, StartDt, DataVersion
	FROM	Region
	WHERE	RegionID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
