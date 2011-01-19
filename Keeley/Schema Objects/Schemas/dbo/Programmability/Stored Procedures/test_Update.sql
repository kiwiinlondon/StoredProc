USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[test_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[test_Update]
GO

CREATE PROCEDURE DBO.[test_Update]
		@blah int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO test_hst (
			blah, EndDt, LastActionUserID)
	SELECT	blah, @StartDt, @UpdateUserID
	FROM	test
	WHERE	 = @

	UPDATE	test
	SET		blah = @blah,  StartDt = @StartDt
	WHERE	 = @
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	test
	WHERE	 = @
	AND		@@ROWCOUNT > 0

GO
