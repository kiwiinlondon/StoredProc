USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[DerivedAssetClass_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[DerivedAssetClass_Delete]
GO

CREATE PROCEDURE DBO.[DerivedAssetClass_Delete]
		@DerivedAssetClassId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO DerivedAssetClass_hst (
			DerivedAssetClassId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	DerivedAssetClassId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	DerivedAssetClass
	WHERE	DerivedAssetClassId = @DerivedAssetClassId

	DELETE	DerivedAssetClass
	WHERE	DerivedAssetClassId = @DerivedAssetClassId
	AND		DataVersion = @DataVersion
GO
