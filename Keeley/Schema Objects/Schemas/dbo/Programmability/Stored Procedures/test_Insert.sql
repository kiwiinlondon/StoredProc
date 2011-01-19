USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[test_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[test_Insert]
GO

CREATE PROCEDURE DBO.[test_Insert]
		@blah int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into test
			(blah, StartDt)
	VALUES
			(@blah, @StartDt)

	SELECT	, StartDt, DataVersion
	FROM	test
	WHERE	 = @
	AND		@@ROWCOUNT > 0

GO
