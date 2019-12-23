USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[BucketValue_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[BucketValue_Update]
GO

CREATE PROCEDURE DBO.[BucketValue_Update]
		@BucketValueId int, 
		@BucketId int, 
		@EntityId int, 
		@EntityId2 int, 
		@NumericValue numeric(28,16), 
		@TextValue varchar(50), 
		@DataVersion rowversion, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO BucketValue_hst (
			BucketValueId, BucketId, EntityId, EntityId2, NumericValue, TextValue, StartDt, DataVersion, UpdateUserID, EndDt, LastActionUserID)
	SELECT	BucketValueId, BucketId, EntityId, EntityId2, NumericValue, TextValue, StartDt, DataVersion, UpdateUserID, @StartDt, @UpdateUserID
	FROM	BucketValue
	WHERE	BucketValueId = @BucketValueId

	UPDATE	BucketValue
	SET		BucketId = @BucketId, EntityId = @EntityId, EntityId2 = @EntityId2, NumericValue = @NumericValue, TextValue = @TextValue, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	BucketValueId = @BucketValueId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	BucketValue
	WHERE	BucketValueId = @BucketValueId
	AND		@@ROWCOUNT > 0

GO
