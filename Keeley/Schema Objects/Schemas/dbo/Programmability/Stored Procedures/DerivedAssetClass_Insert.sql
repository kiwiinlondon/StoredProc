USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[DerivedAssetClass_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[DerivedAssetClass_Insert]
GO

CREATE PROCEDURE DBO.[DerivedAssetClass_Insert]
		@Name varchar(70), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into DerivedAssetClass
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	DerivedAssetClassId, StartDt, DataVersion
	FROM	DerivedAssetClass
	WHERE	DerivedAssetClassId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
