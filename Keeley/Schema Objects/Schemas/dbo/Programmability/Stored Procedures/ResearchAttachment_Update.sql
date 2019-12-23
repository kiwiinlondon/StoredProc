USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ResearchAttachment_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ResearchAttachment_Update]
GO

CREATE PROCEDURE DBO.[ResearchAttachment_Update]
		@ResearchAttachmentId int, 
		@ResearchId int, 
		@FileName varchar(500), 
		@FileExtensionTypeId int, 
		@CodeRedId uniqueidentifier, 
		@Document varbinary(MAX), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ResearchAttachment_hst (
			ResearchAttachmentId, ResearchId, FileName, FileExtensionTypeId, CodeRedId, Document, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ResearchAttachmentId, ResearchId, FileName, FileExtensionTypeId, CodeRedId, Document, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ResearchAttachment
	WHERE	ResearchAttachmentId = @ResearchAttachmentId

	UPDATE	ResearchAttachment
	SET		ResearchId = @ResearchId, FileName = @FileName, FileExtensionTypeId = @FileExtensionTypeId, CodeRedId = @CodeRedId, Document = @Document, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ResearchAttachmentId = @ResearchAttachmentId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ResearchAttachment
	WHERE	ResearchAttachmentId = @ResearchAttachmentId
	AND		@@ROWCOUNT > 0

GO
