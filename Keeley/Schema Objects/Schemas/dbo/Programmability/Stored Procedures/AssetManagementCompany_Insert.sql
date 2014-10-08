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
		@UpdateUserID int, 
		@LegalEntityID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into AssetManagementCompany
			(UpdateUserID, LegalEntityID, StartDt)
	VALUES
			(@UpdateUserID, @LegalEntityID, @StartDt)

	SELECT	LegalEntityID, StartDt, DataVersion
	FROM	AssetManagementCompany
	WHERE	LegalEntityID = @LegalEntityID
	AND		@@ROWCOUNT > 0

GO
