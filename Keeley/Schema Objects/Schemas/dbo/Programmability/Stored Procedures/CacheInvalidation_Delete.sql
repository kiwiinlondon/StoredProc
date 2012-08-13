USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[CacheInvalidation_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[CacheInvalidation_Delete]
GO

CREATE PROCEDURE DBO.[CacheInvalidation_Delete]
		@CacheName varchar,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO CacheInvalidation_hst (
			CacheName, DataVersion, CacheTime, EndDt, LastActionUserID)
	SELECT	CacheName, DataVersion, CacheTime, @EndDt, @UpdateUserID
	FROM	CacheInvalidation
	WHERE	CacheName = @CacheName

	DELETE	CacheInvalidation
	WHERE	CacheName = @CacheName
	AND		DataVersion = @DataVersion
GO
