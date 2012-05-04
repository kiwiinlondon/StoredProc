USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[DayCountConvention_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[DayCountConvention_Update]
GO

CREATE PROCEDURE DBO.[DayCountConvention_Update]
		@DayConventionID int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO DayCountConvention_hst (
			DayConventionID, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	DayConventionID, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	DayCountConvention
	WHERE	DayConventionID = @DayConventionID

	UPDATE	DayCountConvention
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	DayConventionID = @DayConventionID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	DayCountConvention
	WHERE	DayConventionID = @DayConventionID
	AND		@@ROWCOUNT > 0

GO
