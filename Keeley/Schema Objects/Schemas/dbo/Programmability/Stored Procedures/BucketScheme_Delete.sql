USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[BucketScheme_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[BucketScheme_Delete]
GO

CREATE PROCEDURE DBO.[BucketScheme_Delete]
		@BucketSchemeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO BucketScheme_hst (
			BucketSchemeId, Name, Description, EntityTypeId, EntityTypeId2, TypeCodeId, OwnerApplicationUserId, UpdateUserID, StartDt, DataVersion, EndDt, LastActionUserID)
	SELECT	BucketSchemeId, Name, Description, EntityTypeId, EntityTypeId2, TypeCodeId, OwnerApplicationUserId, UpdateUserID, StartDt, DataVersion, @EndDt, @UpdateUserID
	FROM	BucketScheme
	WHERE	BucketSchemeId = @BucketSchemeId

	DELETE	BucketScheme
	WHERE	BucketSchemeId = @BucketSchemeId
	AND		DataVersion = @DataVersion
GO
