USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[MatchedStatus_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[MatchedStatus_Update]
GO

CREATE PROCEDURE DBO.[MatchedStatus_Update]
		@MatchedStatusID int, 
		@Code varchar(30), 
		@Name varchar(200), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO MatchedStatus_hst (
			MatchedStatusID, Code, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	MatchedStatusID, Code, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	MatchedStatus
	WHERE	MatchedStatusID = @MatchedStatusID

	UPDATE	MatchedStatus
	SET		Code = @Code, Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	MatchedStatusID = @MatchedStatusID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	MatchedStatus
	WHERE	MatchedStatusID = @MatchedStatusID
	AND		@@ROWCOUNT > 0

GO
