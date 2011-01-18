USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Region_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Region_Update]
GO

CREATE PROCEDURE DBO.[Region_Update]
		@RegionID int, 
		@Name varchar, 
		@IsoCode varchar, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Region_hst (
			RegionID, Name, IsoCode, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	RegionID, Name, IsoCode, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	Region
	WHERE	RegionID = RegionID

	UPDATE	Region
	SET		Name = @Name, IsoCode = @IsoCode, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	RegionID = @RegionID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Region
	WHERE	RegionID = @RegionID
	AND		@@ROWCOUNT > 0

GO
