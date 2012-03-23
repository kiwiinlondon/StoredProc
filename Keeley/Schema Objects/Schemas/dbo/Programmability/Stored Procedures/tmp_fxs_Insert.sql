USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[tmp_fxs_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[tmp_fxs_Insert]
GO

CREATE PROCEDURE DBO.[tmp_fxs_Insert]
		@eventid int, 
		@paybookxrate numeric(35,16), 
		@receivebookxrate numeric(35,16)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into tmp_fxs
			(eventid, paybookxrate, receivebookxrate, StartDt)
	VALUES
			(@eventid, @paybookxrate, @receivebookxrate, @StartDt)

	SELECT	, StartDt, DataVersion
	FROM	tmp_fxs
	WHERE	 = @
	AND		@@ROWCOUNT > 0

GO
