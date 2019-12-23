USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[BucketValue_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[BucketValue_Insert]
GO

CREATE PROCEDURE DBO.[BucketValue_Insert]
		@BucketValueId int, 
		@BucketId int, 
		@EntityId int, 
		@EntityId2 int, 
		@NumericValue numeric(28,16), 
		@TextValue varchar(50), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into BucketValue
			(BucketValueId, BucketId, EntityId, EntityId2, NumericValue, TextValue, UpdateUserID, StartDt)
	VALUES
			(@BucketValueId, @BucketId, @EntityId, @EntityId2, @NumericValue, @TextValue, @UpdateUserID, @StartDt)

	SELECT	BucketValueId, StartDt, DataVersion
	FROM	BucketValue
	WHERE	BucketValueId = @BucketValueId
	AND		@@ROWCOUNT > 0

GO
