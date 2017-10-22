USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[BondMaturityType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[BondMaturityType_Delete]
GO

CREATE PROCEDURE DBO.[BondMaturityType_Delete]
		@BondMaturityTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO BondMaturityType_hst (
			BondMaturityTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	BondMaturityTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	BondMaturityType
	WHERE	BondMaturityTypeId = @BondMaturityTypeId

	DELETE	BondMaturityType
	WHERE	BondMaturityTypeId = @BondMaturityTypeId
	AND		DataVersion = @DataVersion
GO
