USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Bucket_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Bucket_Delete]
GO

CREATE PROCEDURE DBO.[Bucket_Delete]
		@BucketId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Bucket_hst (
			BucketId, BucketSchemeId, Name, IsDefaultBucket, LimitValue, IsLimitInclusive, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	BucketId, BucketSchemeId, Name, IsDefaultBucket, LimitValue, IsLimitInclusive, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	Bucket
	WHERE	BucketId = @BucketId

	DELETE	Bucket
	WHERE	BucketId = @BucketId
	AND		DataVersion = @DataVersion
GO
