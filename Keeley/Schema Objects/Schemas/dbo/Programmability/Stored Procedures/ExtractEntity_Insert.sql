USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractEntity_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractEntity_Insert]
GO

CREATE PROCEDURE DBO.[ExtractEntity_Insert]
		@ExtractId int, 
		@EntityId int, 
		@LastSentInExtractRunId int, 
		@IsCancelled bit, 
		@SendInNextRun bit, 
		@UpdateUserID int, 
		@EntityTypeId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ExtractEntity
			(ExtractId, EntityId, LastSentInExtractRunId, IsCancelled, SendInNextRun, UpdateUserID, EntityTypeId, StartDt)
	VALUES
			(@ExtractId, @EntityId, @LastSentInExtractRunId, @IsCancelled, @SendInNextRun, @UpdateUserID, @EntityTypeId, @StartDt)

	SELECT	ExtractEntityID, StartDt, DataVersion
	FROM	ExtractEntity
	WHERE	ExtractEntityID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
