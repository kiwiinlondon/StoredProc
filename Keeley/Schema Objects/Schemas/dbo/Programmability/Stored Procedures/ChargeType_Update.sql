USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ChargeType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ChargeType_Update]
GO

CREATE PROCEDURE DBO.[ChargeType_Update]
		@ChargeTypeId int, 
		@Code varchar(30), 
		@Name varchar(200), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ChargeType_hst (
			ChargeTypeId, Code, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ChargeTypeId, Code, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ChargeType
	WHERE	ChargeTypeId = @ChargeTypeId

	UPDATE	ChargeType
	SET		Code = @Code, Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ChargeTypeId = @ChargeTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ChargeType
	WHERE	ChargeTypeId = @ChargeTypeId
	AND		@@ROWCOUNT > 0

GO
