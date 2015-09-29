USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[CorporateActionType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[CorporateActionType_Insert]
GO

CREATE PROCEDURE DBO.[CorporateActionType_Insert]
		@Name varchar(128), 
		@InputDate datetime, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into CorporateActionType
			(Name, InputDate, UpdateUserID, StartDt)
	VALUES
			(@Name, @InputDate, @UpdateUserID, @StartDt)

	SELECT	CorporateActionTypeId, StartDt, DataVersion
	FROM	CorporateActionType
	WHERE	CorporateActionTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
