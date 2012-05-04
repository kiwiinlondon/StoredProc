USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ChargeType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ChargeType_Delete]
GO

CREATE PROCEDURE DBO.[ChargeType_Delete]
		@ChargeTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ChargeType_hst (
			ChargeTypeId, Code, Name, StartDt, UpdateUserID, DataVersion, PaidToCustodian, EndDt, LastActionUserID)
	SELECT	ChargeTypeId, Code, Name, StartDt, UpdateUserID, DataVersion, PaidToCustodian, @EndDt, @UpdateUserID
	FROM	ChargeType
	WHERE	ChargeTypeId = @ChargeTypeId

	DELETE	ChargeType
	WHERE	ChargeTypeId = @ChargeTypeId
	AND		DataVersion = @DataVersion
GO
