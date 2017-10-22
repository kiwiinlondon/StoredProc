USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[BondMaturityType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[BondMaturityType_Insert]
GO

CREATE PROCEDURE DBO.[BondMaturityType_Insert]
		@Name varchar(50), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into BondMaturityType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	BondMaturityTypeId, StartDt, DataVersion
	FROM	BondMaturityType
	WHERE	BondMaturityTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
