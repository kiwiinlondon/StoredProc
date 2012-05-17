USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AssetManagementCompany_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AssetManagementCompany_Insert]
GO

CREATE PROCEDURE DBO.[AssetManagementCompany_Insert]
		@Name varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into AssetManagementCompany
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	AssetManagementCompanyId, StartDt, DataVersion
	FROM	AssetManagementCompany
	WHERE	AssetManagementCompanyId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
