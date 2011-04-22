USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractEntity_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractEntity_Delete]
GO

CREATE PROCEDURE DBO.[ExtractEntity_Delete]
		@ExtractEntityID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ExtractEntity_hst (
			ExtractEntityID, ExtractId, EntityId, LastSentInExtractRunId, IsCancelled, SendInNextRun, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractEntityID, ExtractId, EntityId, LastSentInExtractRunId, IsCancelled, SendInNextRun, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ExtractEntity
	WHERE	ExtractEntityID = @ExtractEntityID

	DELETE	ExtractEntity
	WHERE	ExtractEntityID = @ExtractEntityID
	AND		DataVersion = @DataVersion
GO
