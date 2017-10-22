USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundStructure_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundStructure_Insert]
GO

CREATE PROCEDURE DBO.[FundStructure_Insert]
		@Name varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FundStructure
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	FundStructureId, StartDt, DataVersion
	FROM	FundStructure
	WHERE	FundStructureId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
