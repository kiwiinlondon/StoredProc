USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ResearchContributor_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ResearchContributor_Delete]
GO

CREATE PROCEDURE DBO.[ResearchContributor_Delete]
		@UserId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ResearchContributor_hst (
			UserId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	UserId, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ResearchContributor
	WHERE	UserId = @UserId

	DELETE	ResearchContributor
	WHERE	UserId = @UserId
	AND		DataVersion = @DataVersion
GO
