USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[test_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[test_Delete]
GO

CREATE PROCEDURE DBO.[test_Delete]
		@ ,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO test_hst (
			blah, EndDt, LastActionUserID)
	SELECT	blah, @EndDt, @UpdateUserID
	FROM	test
	WHERE	 = @

	DELETE	test
	WHERE	 = @
	AND		DataVersion = @DataVersion
GO
