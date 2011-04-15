USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InstrumentClassHierarchy_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InstrumentClassHierarchy_Insert]
GO

CREATE PROCEDURE DBO.[InstrumentClassHierarchy_Insert]
		@Name varchar(50), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into InstrumentClassHierarchy
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	InstrumentClassHierarchyId, StartDt, DataVersion
	FROM	InstrumentClassHierarchy
	WHERE	InstrumentClassHierarchyId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
