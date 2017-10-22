USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[BondMaturityType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[BondMaturityType_Update]
GO

CREATE PROCEDURE DBO.[BondMaturityType_Update]
		@BondMaturityTypeId int, 
		@Name varchar(50), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO BondMaturityType_hst (
			BondMaturityTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	BondMaturityTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	BondMaturityType
	WHERE	BondMaturityTypeId = @BondMaturityTypeId

	UPDATE	BondMaturityType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	BondMaturityTypeId = @BondMaturityTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	BondMaturityType
	WHERE	BondMaturityTypeId = @BondMaturityTypeId
	AND		@@ROWCOUNT > 0

GO
