USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Periodicity_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Periodicity_Update]
GO

CREATE PROCEDURE DBO.[Periodicity_Update]
		@PeriodicityId int, 
		@PeriodicityTypeId int, 
		@Name varchar(200), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Periodicity_hst (
			PeriodicityId, PeriodicityTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PeriodicityId, PeriodicityTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	Periodicity
	WHERE	PeriodicityId = @PeriodicityId

	UPDATE	Periodicity
	SET		PeriodicityTypeId = @PeriodicityTypeId, Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	PeriodicityId = @PeriodicityId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Periodicity
	WHERE	PeriodicityId = @PeriodicityId
	AND		@@ROWCOUNT > 0

GO
