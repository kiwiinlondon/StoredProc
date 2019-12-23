USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Bucket_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Bucket_Update]
GO

CREATE PROCEDURE DBO.[Bucket_Update]
		@BucketId int, 
		@BucketSchemeId int, 
		@Name varchar(50), 
		@IsDefaultBucket bit, 
		@LimitValue numeric(28,16), 
		@IsLimitInclusive bit, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Bucket_hst (
			BucketId, BucketSchemeId, Name, IsDefaultBucket, LimitValue, IsLimitInclusive, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	BucketId, BucketSchemeId, Name, IsDefaultBucket, LimitValue, IsLimitInclusive, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	Bucket
	WHERE	BucketId = @BucketId

	UPDATE	Bucket
	SET		BucketSchemeId = @BucketSchemeId, Name = @Name, IsDefaultBucket = @IsDefaultBucket, LimitValue = @LimitValue, IsLimitInclusive = @IsLimitInclusive, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	BucketId = @BucketId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Bucket
	WHERE	BucketId = @BucketId
	AND		@@ROWCOUNT > 0

GO
