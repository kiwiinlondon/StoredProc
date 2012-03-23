USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[tmp_fxs_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[tmp_fxs_Update]
GO

CREATE PROCEDURE DBO.[tmp_fxs_Update]
		@eventid int, 
		@paybookxrate numeric(35,16), 
		@receivebookxrate numeric(35,16)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO tmp_fxs_hst (
			eventid, paybookxrate, receivebookxrate, EndDt, LastActionUserID)
	SELECT	eventid, paybookxrate, receivebookxrate, @StartDt, @UpdateUserID
	FROM	tmp_fxs
	WHERE	 = @

	UPDATE	tmp_fxs
	SET		eventid = @eventid, paybookxrate = @paybookxrate, receivebookxrate = @receivebookxrate,  StartDt = @StartDt
	WHERE	 = @
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	tmp_fxs
	WHERE	 = @
	AND		@@ROWCOUNT > 0

GO
