USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Periodicity_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Periodicity_Insert]
GO

CREATE PROCEDURE DBO.[Periodicity_Insert]
		@PeriodicityTypeId int, 
		@Name varchar(200), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Periodicity
			(PeriodicityTypeId, Name, UpdateUserID, StartDt)
	VALUES
			(@PeriodicityTypeId, @Name, @UpdateUserID, @StartDt)

	SELECT	PeriodicityId, StartDt, DataVersion
	FROM	Periodicity
	WHERE	PeriodicityId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
