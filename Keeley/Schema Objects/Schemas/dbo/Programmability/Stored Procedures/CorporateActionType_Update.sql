USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[CorporateActionType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[CorporateActionType_Update]
GO

CREATE PROCEDURE DBO.[CorporateActionType_Update]
		@CorporateActionTypeId int, 
		@Name varchar(128), 
		@InputDate datetime, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO CorporateActionType_hst (
			CorporateActionTypeId, Name, InputDate, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	CorporateActionTypeId, Name, InputDate, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	CorporateActionType
	WHERE	CorporateActionTypeId = @CorporateActionTypeId

	UPDATE	CorporateActionType
	SET		Name = @Name, InputDate = @InputDate, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	CorporateActionTypeId = @CorporateActionTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	CorporateActionType
	WHERE	CorporateActionTypeId = @CorporateActionTypeId
	AND		@@ROWCOUNT > 0

GO
