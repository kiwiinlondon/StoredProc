USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PeriodicityType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PeriodicityType_Insert]
GO

CREATE PROCEDURE DBO.[PeriodicityType_Insert]
		@Name varchar(200), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PeriodicityType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	PeriodicityTypeId, StartDt, DataVersion
	FROM	PeriodicityType
	WHERE	PeriodicityTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
