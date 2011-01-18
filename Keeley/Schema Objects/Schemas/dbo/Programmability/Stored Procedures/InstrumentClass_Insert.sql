USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InstrumentClass_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InstrumentClass_Insert]
GO

CREATE PROCEDURE DBO.[InstrumentClass_Insert]
		@ParentInstrumentClassID int, 
		@FMInstClass varchar(100), 
		@Name varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into InstrumentClass
			(ParentInstrumentClassID, FMInstClass, Name, UpdateUserID, StartDt)
	VALUES
			(@ParentInstrumentClassID, @FMInstClass, @Name, @UpdateUserID, @StartDt)

	SELECT	InstrumentClassID, StartDt, DataVersion
	FROM	InstrumentClass
	WHERE	InstrumentClassID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
