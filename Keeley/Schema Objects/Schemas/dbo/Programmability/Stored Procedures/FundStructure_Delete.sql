USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundStructure_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundStructure_Delete]
GO

CREATE PROCEDURE DBO.[FundStructure_Delete]
		@FundStructureId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FundStructure_hst (
			FundStructureId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FundStructureId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	FundStructure
	WHERE	FundStructureId = @FundStructureId

	DELETE	FundStructure
	WHERE	FundStructureId = @FundStructureId
	AND		DataVersion = @DataVersion
GO
