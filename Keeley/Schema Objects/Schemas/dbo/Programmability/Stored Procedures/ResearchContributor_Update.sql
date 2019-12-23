USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ResearchContributor_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ResearchContributor_Update]
GO

CREATE PROCEDURE DBO.[ResearchContributor_Update]
		@UserId int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ResearchContributor_hst (
			UserId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	UserId, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ResearchContributor
	WHERE	UserId = @UserId

	UPDATE	ResearchContributor
	SET		UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	UserId = @UserId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ResearchContributor
	WHERE	UserId = @UserId
	AND		@@ROWCOUNT > 0

GO
