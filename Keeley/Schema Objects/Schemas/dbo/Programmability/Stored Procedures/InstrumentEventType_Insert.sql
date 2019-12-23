USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InstrumentEventType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InstrumentEventType_Insert]
GO

CREATE PROCEDURE DBO.[InstrumentEventType_Insert]
		@Name varchar(70), 
		@UpdateUserID int, 
		@FmCnevSubType varchar(70)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into InstrumentEventType
			(Name, UpdateUserID, FmCnevSubType, StartDt)
	VALUES
			(@Name, @UpdateUserID, @FmCnevSubType, @StartDt)

	SELECT	InstrumentEventTypeID, StartDt, DataVersion
	FROM	InstrumentEventType
	WHERE	InstrumentEventTypeID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
