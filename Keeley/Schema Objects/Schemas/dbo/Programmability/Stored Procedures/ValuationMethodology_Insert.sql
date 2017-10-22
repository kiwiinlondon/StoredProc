USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ValuationMethodology_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ValuationMethodology_Insert]
GO

CREATE PROCEDURE DBO.[ValuationMethodology_Insert]
		@Name varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ValuationMethodology
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	ValuationMethodologyId, StartDt, DataVersion
	FROM	ValuationMethodology
	WHERE	ValuationMethodologyId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
