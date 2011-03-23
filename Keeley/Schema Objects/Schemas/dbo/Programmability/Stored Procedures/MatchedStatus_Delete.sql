USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[MatchedStatus_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[MatchedStatus_Delete]
GO

CREATE PROCEDURE DBO.[MatchedStatus_Delete]
		@MatchedStatusID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO MatchedStatus_hst (
			MatchedStatusID, Code, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	MatchedStatusID, Code, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	MatchedStatus
	WHERE	MatchedStatusID = @MatchedStatusID

	DELETE	MatchedStatus
	WHERE	MatchedStatusID = @MatchedStatusID
	AND		DataVersion = @DataVersion
GO
