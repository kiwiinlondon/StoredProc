USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Extract_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Extract_Update]
GO

CREATE PROCEDURE DBO.[Extract_Update]
		@ExtractID int, 
		@ExtractTypeId int, 
		@Name varchar(70), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@ExtractOutputTypeID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Extract_hst (
			ExtractID, ExtractTypeId, Name, StartDt, UpdateUserID, DataVersion, ExtractOutputTypeID, EndDt, LastActionUserID)
	SELECT	ExtractID, ExtractTypeId, Name, StartDt, UpdateUserID, DataVersion, ExtractOutputTypeID, @StartDt, @UpdateUserID
	FROM	Extract
	WHERE	ExtractID = @ExtractID

	UPDATE	Extract
	SET		ExtractTypeId = @ExtractTypeId, Name = @Name, UpdateUserID = @UpdateUserID, ExtractOutputTypeID = @ExtractOutputTypeID,  StartDt = @StartDt
	WHERE	ExtractID = @ExtractID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Extract
	WHERE	ExtractID = @ExtractID
	AND		@@ROWCOUNT > 0

GO
