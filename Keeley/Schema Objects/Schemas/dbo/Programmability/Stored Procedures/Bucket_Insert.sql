USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Bucket_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Bucket_Insert]
GO

CREATE PROCEDURE DBO.[Bucket_Insert]
		@BucketId int, 
		@BucketSchemeId int, 
		@Name varchar(50), 
		@IsDefaultBucket bit, 
		@LimitValue numeric(28,16), 
		@IsLimitInclusive bit, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Bucket
			(BucketId, BucketSchemeId, Name, IsDefaultBucket, LimitValue, IsLimitInclusive, UpdateUserID, StartDt)
	VALUES
			(@BucketId, @BucketSchemeId, @Name, @IsDefaultBucket, @LimitValue, @IsLimitInclusive, @UpdateUserID, @StartDt)

	SELECT	BucketId, StartDt, DataVersion
	FROM	Bucket
	WHERE	BucketId = @BucketId
	AND		@@ROWCOUNT > 0

GO
