USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[CacheInvalidation_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[CacheInvalidation_Update]
GO

CREATE PROCEDURE DBO.[CacheInvalidation_Update]
		@CacheName varchar(50), 
		@DataVersion rowversion, 
		@CacheTime datetime
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO CacheInvalidation_hst (
			CacheName, DataVersion, CacheTime, EndDt, LastActionUserID)
	SELECT	CacheName, DataVersion, CacheTime, @StartDt, @UpdateUserID
	FROM	CacheInvalidation
	WHERE	CacheName = @CacheName

	UPDATE	CacheInvalidation
	SET		CacheTime = @CacheTime,  StartDt = @StartDt
	WHERE	CacheName = @CacheName
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	CacheInvalidation
	WHERE	CacheName = @CacheName
	AND		@@ROWCOUNT > 0

GO
