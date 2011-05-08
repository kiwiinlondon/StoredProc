USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityRankingScheme_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityRankingScheme_Insert]
GO

CREATE PROCEDURE DBO.[EntityRankingScheme_Insert]
		@Name varchar(100), 
		@FMValueSchemeId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into EntityRankingScheme
			(Name, FMValueSchemeId, UpdateUserID, StartDt)
	VALUES
			(@Name, @FMValueSchemeId, @UpdateUserID, @StartDt)

	SELECT	EntityRankingSchemeId, StartDt, DataVersion
	FROM	EntityRankingScheme
	WHERE	EntityRankingSchemeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
