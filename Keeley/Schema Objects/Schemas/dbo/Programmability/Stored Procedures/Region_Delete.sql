USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Region_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Region_Delete]

GO
CREATE PROCEDURE DBO.[Region_Delete]
		@RegionID timestamp,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Region_hst (
			RegionID, Name, IsoCode, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	RegionID, Name, IsoCode, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	Region
	WHERE	RegionID = RegionID

	DELETE	Region
	WHERE	RegionID = @RegionID
	AND		DataVersion = @DataVersion
GO
