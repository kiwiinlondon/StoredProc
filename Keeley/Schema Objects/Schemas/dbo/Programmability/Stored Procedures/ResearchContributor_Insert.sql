USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ResearchContributor_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ResearchContributor_Insert]
GO

CREATE PROCEDURE DBO.[ResearchContributor_Insert]
		@UserId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ResearchContributor
			(UserId, UpdateUserID, StartDt)
	VALUES
			(@UserId, @UpdateUserID, @StartDt)

	SELECT	UserId, StartDt, DataVersion
	FROM	ResearchContributor
	WHERE	UserId = @UserId
	AND		@@ROWCOUNT > 0

GO
