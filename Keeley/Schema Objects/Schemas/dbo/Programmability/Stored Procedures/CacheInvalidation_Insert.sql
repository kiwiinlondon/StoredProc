USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[CacheInvalidation_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[CacheInvalidation_Insert]
GO

CREATE PROCEDURE DBO.[CacheInvalidation_Insert]
		@CacheName varchar(50), 
		@CacheTime datetime
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into CacheInvalidation
			(CacheName, CacheTime, StartDt)
	VALUES
			(@CacheName, @CacheTime, @StartDt)

	SELECT	CacheName, StartDt, DataVersion
	FROM	CacheInvalidation
	WHERE	CacheName = @CacheName
	AND		@@ROWCOUNT > 0

GO
