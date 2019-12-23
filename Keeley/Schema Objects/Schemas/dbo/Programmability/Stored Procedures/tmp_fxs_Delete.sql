USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[tmp_fxs_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[tmp_fxs_Delete]
GO

CREATE PROCEDURE DBO.[tmp_fxs_Delete]
		@ ,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO tmp_fxs_hst (
			eventid, paybookxrate, receivebookxrate, EndDt, LastActionUserID)
	SELECT	eventid, paybookxrate, receivebookxrate, @EndDt, @UpdateUserID
	FROM	tmp_fxs
	WHERE	 = @

	DELETE	tmp_fxs
	WHERE	 = @
	AND		DataVersion = @DataVersion
GO
