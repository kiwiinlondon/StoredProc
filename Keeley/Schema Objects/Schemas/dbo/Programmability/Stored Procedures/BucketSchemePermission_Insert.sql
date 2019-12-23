USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[BucketSchemePermission_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[BucketSchemePermission_Insert]
GO

CREATE PROCEDURE DBO.[BucketSchemePermission_Insert]
		@BucketSchemePermissionId int, 
		@BucketSchemeId int, 
		@IsEditable bit, 
		@ApplicationUserId int, 
		@ADGroupName varchar(250), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into BucketSchemePermission
			(BucketSchemePermissionId, BucketSchemeId, IsEditable, ApplicationUserId, ADGroupName, UpdateUserID, StartDt)
	VALUES
			(@BucketSchemePermissionId, @BucketSchemeId, @IsEditable, @ApplicationUserId, @ADGroupName, @UpdateUserID, @StartDt)

	SELECT	BucketSchemePermissionId, StartDt, DataVersion
	FROM	BucketSchemePermission
	WHERE	BucketSchemePermissionId = @BucketSchemePermissionId
	AND		@@ROWCOUNT > 0

GO
