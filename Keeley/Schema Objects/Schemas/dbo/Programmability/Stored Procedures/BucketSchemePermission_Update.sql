USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[BucketSchemePermission_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[BucketSchemePermission_Update]
GO

CREATE PROCEDURE DBO.[BucketSchemePermission_Update]
		@BucketSchemePermissionId int, 
		@BucketSchemeId int, 
		@IsEditable bit, 
		@ApplicationUserId int, 
		@ADGroupName varchar(250), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO BucketSchemePermission_hst (
			BucketSchemePermissionId, BucketSchemeId, IsEditable, ApplicationUserId, ADGroupName, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	BucketSchemePermissionId, BucketSchemeId, IsEditable, ApplicationUserId, ADGroupName, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	BucketSchemePermission
	WHERE	BucketSchemePermissionId = @BucketSchemePermissionId

	UPDATE	BucketSchemePermission
	SET		BucketSchemeId = @BucketSchemeId, IsEditable = @IsEditable, ApplicationUserId = @ApplicationUserId, ADGroupName = @ADGroupName, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	BucketSchemePermissionId = @BucketSchemePermissionId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	BucketSchemePermission
	WHERE	BucketSchemePermissionId = @BucketSchemePermissionId
	AND		@@ROWCOUNT > 0

GO
