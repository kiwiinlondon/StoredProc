USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ResearchAttachment_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ResearchAttachment_Insert]
GO

CREATE PROCEDURE DBO.[ResearchAttachment_Insert]
		@ResearchId int, 
		@FileName varchar(500), 
		@FileExtensionTypeId int, 
		@CodeRedId uniqueidentifier, 
		@Document varbinary(MAX), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ResearchAttachment
			(ResearchId, FileName, FileExtensionTypeId, CodeRedId, Document, UpdateUserID, StartDt)
	VALUES
			(@ResearchId, @FileName, @FileExtensionTypeId, @CodeRedId, @Document, @UpdateUserID, @StartDt)

	SELECT	ResearchAttachmentId, StartDt, DataVersion
	FROM	ResearchAttachment
	WHERE	ResearchAttachmentId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
