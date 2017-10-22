USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundStructure_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundStructure_Update]
GO

CREATE PROCEDURE DBO.[FundStructure_Update]
		@FundStructureId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FundStructure_hst (
			FundStructureId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FundStructureId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	FundStructure
	WHERE	FundStructureId = @FundStructureId

	UPDATE	FundStructure
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	FundStructureId = @FundStructureId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FundStructure
	WHERE	FundStructureId = @FundStructureId
	AND		@@ROWCOUNT > 0

GO
