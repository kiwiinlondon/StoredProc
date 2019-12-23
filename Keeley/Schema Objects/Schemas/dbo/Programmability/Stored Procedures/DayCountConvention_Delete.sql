USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[DayCountConvention_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[DayCountConvention_Delete]
GO

CREATE PROCEDURE DBO.[DayCountConvention_Delete]
		@DayConventionID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO DayCountConvention_hst (
			DayConventionID, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	DayConventionID, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	DayCountConvention
	WHERE	DayConventionID = @DayConventionID

	DELETE	DayCountConvention
	WHERE	DayConventionID = @DayConventionID
	AND		DataVersion = @DataVersion
GO
