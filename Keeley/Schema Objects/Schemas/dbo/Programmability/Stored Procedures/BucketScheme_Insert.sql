USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[BucketScheme_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[BucketScheme_Insert]
GO

CREATE PROCEDURE DBO.[BucketScheme_Insert]
		@BucketSchemeId int, 
		@Name varchar(250), 
		@Description varchar(1000), 
		@EntityTypeId int, 
		@EntityTypeId2 int, 
		@TypeCodeId int, 
		@OwnerApplicationUserId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into BucketScheme
			(BucketSchemeId, Name, Description, EntityTypeId, EntityTypeId2, TypeCodeId, OwnerApplicationUserId, UpdateUserID, StartDt)
	VALUES
			(@BucketSchemeId, @Name, @Description, @EntityTypeId, @EntityTypeId2, @TypeCodeId, @OwnerApplicationUserId, @UpdateUserID, @StartDt)

	SELECT	BucketSchemeId, StartDt, DataVersion
	FROM	BucketScheme
	WHERE	BucketSchemeId = @BucketSchemeId
	AND		@@ROWCOUNT > 0

GO
