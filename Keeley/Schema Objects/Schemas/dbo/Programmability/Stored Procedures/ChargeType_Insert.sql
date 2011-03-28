USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ChargeType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ChargeType_Insert]
GO

CREATE PROCEDURE DBO.[ChargeType_Insert]
		@Code varchar(30), 
		@Name varchar(200), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ChargeType
			(Code, Name, UpdateUserID, StartDt)
	VALUES
			(@Code, @Name, @UpdateUserID, @StartDt)

	SELECT	ChargeTypeId, StartDt, DataVersion
	FROM	ChargeType
	WHERE	ChargeTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
