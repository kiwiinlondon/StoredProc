USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ResearchAttachment_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ResearchAttachment_Delete]
GO

CREATE PROCEDURE DBO.[ResearchAttachment_Delete]
		@ResearchAttachmentId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ResearchAttachment_hst (
			ResearchAttachmentId, ResearchId, FileName, FileExtensionTypeId, CodeRedId, Document, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ResearchAttachmentId, ResearchId, FileName, FileExtensionTypeId, CodeRedId, Document, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ResearchAttachment
	WHERE	ResearchAttachmentId = @ResearchAttachmentId

	DELETE	ResearchAttachment
	WHERE	ResearchAttachmentId = @ResearchAttachmentId
	AND		DataVersion = @DataVersion
GO
