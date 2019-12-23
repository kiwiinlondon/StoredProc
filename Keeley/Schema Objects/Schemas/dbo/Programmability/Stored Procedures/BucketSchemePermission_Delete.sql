USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[BucketSchemePermission_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[BucketSchemePermission_Delete]
GO

CREATE PROCEDURE DBO.[BucketSchemePermission_Delete]
		@BucketSchemePermissionId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO BucketSchemePermission_hst (
			BucketSchemePermissionId, BucketSchemeId, IsEditable, ApplicationUserId, ADGroupName, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	BucketSchemePermissionId, BucketSchemeId, IsEditable, ApplicationUserId, ADGroupName, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	BucketSchemePermission
	WHERE	BucketSchemePermissionId = @BucketSchemePermissionId

	DELETE	BucketSchemePermission
	WHERE	BucketSchemePermissionId = @BucketSchemePermissionId
	AND		DataVersion = @DataVersion
GO
