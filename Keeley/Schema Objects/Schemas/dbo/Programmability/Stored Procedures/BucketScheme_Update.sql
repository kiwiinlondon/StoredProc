USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[BucketScheme_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[BucketScheme_Update]
GO

CREATE PROCEDURE DBO.[BucketScheme_Update]
		@BucketSchemeId int, 
		@Name varchar(250), 
		@Description varchar(1000), 
		@EntityTypeId int, 
		@EntityTypeId2 int, 
		@TypeCodeId int, 
		@OwnerApplicationUserId int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO BucketScheme_hst (
			BucketSchemeId, Name, Description, EntityTypeId, EntityTypeId2, TypeCodeId, OwnerApplicationUserId, UpdateUserID, StartDt, DataVersion, EndDt, LastActionUserID)
	SELECT	BucketSchemeId, Name, Description, EntityTypeId, EntityTypeId2, TypeCodeId, OwnerApplicationUserId, UpdateUserID, StartDt, DataVersion, @StartDt, @UpdateUserID
	FROM	BucketScheme
	WHERE	BucketSchemeId = @BucketSchemeId

	UPDATE	BucketScheme
	SET		Name = @Name, Description = @Description, EntityTypeId = @EntityTypeId, EntityTypeId2 = @EntityTypeId2, TypeCodeId = @TypeCodeId, OwnerApplicationUserId = @OwnerApplicationUserId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	BucketSchemeId = @BucketSchemeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	BucketScheme
	WHERE	BucketSchemeId = @BucketSchemeId
	AND		@@ROWCOUNT > 0

GO
