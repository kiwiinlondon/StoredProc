USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[CorporateActionType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[CorporateActionType_Delete]
GO

CREATE PROCEDURE DBO.[CorporateActionType_Delete]
		@CorporateActionTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO CorporateActionType_hst (
			CorporateActionTypeId, Name, InputDate, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	CorporateActionTypeId, Name, InputDate, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	CorporateActionType
	WHERE	CorporateActionTypeId = @CorporateActionTypeId

	DELETE	CorporateActionType
	WHERE	CorporateActionTypeId = @CorporateActionTypeId
	AND		DataVersion = @DataVersion
GO
