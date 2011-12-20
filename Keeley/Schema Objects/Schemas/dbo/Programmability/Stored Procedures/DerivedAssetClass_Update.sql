USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[DerivedAssetClass_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[DerivedAssetClass_Update]
GO

CREATE PROCEDURE DBO.[DerivedAssetClass_Update]
		@DerivedAssetClassId int, 
		@Name varchar(70), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO DerivedAssetClass_hst (
			DerivedAssetClassId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	DerivedAssetClassId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	DerivedAssetClass
	WHERE	DerivedAssetClassId = @DerivedAssetClassId

	UPDATE	DerivedAssetClass
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	DerivedAssetClassId = @DerivedAssetClassId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	DerivedAssetClass
	WHERE	DerivedAssetClassId = @DerivedAssetClassId
	AND		@@ROWCOUNT > 0

GO
