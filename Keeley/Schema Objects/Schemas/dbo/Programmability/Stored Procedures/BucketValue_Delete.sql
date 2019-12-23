USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[BucketValue_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[BucketValue_Delete]
GO

CREATE PROCEDURE DBO.[BucketValue_Delete]
		@BucketValueId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO BucketValue_hst (
			BucketValueId, BucketId, EntityId, EntityId2, NumericValue, TextValue, StartDt, DataVersion, UpdateUserID, EndDt, LastActionUserID)
	SELECT	BucketValueId, BucketId, EntityId, EntityId2, NumericValue, TextValue, StartDt, DataVersion, UpdateUserID, @EndDt, @UpdateUserID
	FROM	BucketValue
	WHERE	BucketValueId = @BucketValueId

	DELETE	BucketValue
	WHERE	BucketValueId = @BucketValueId
	AND		DataVersion = @DataVersion
GO
