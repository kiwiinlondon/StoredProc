USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractEntity_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractEntity_Update]
GO

CREATE PROCEDURE DBO.[ExtractEntity_Update]
		@ExtractEntityID int, 
		@ExtractId int, 
		@EntityId int, 
		@LastSentInExtractRunId int, 
		@IsCancelled bit, 
		@SendInNextRun bit, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@EntityTypeId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ExtractEntity_hst (
			ExtractEntityID, ExtractId, EntityId, LastSentInExtractRunId, IsCancelled, SendInNextRun, StartDt, UpdateUserID, DataVersion, EntityTypeId, EndDt, LastActionUserID)
	SELECT	ExtractEntityID, ExtractId, EntityId, LastSentInExtractRunId, IsCancelled, SendInNextRun, StartDt, UpdateUserID, DataVersion, EntityTypeId, @StartDt, @UpdateUserID
	FROM	ExtractEntity
	WHERE	ExtractEntityID = @ExtractEntityID

	UPDATE	ExtractEntity
	SET		ExtractId = @ExtractId, EntityId = @EntityId, LastSentInExtractRunId = @LastSentInExtractRunId, IsCancelled = @IsCancelled, SendInNextRun = @SendInNextRun, UpdateUserID = @UpdateUserID, EntityTypeId = @EntityTypeId,  StartDt = @StartDt
	WHERE	ExtractEntityID = @ExtractEntityID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ExtractEntity
	WHERE	ExtractEntityID = @ExtractEntityID
	AND		@@ROWCOUNT > 0

GO
