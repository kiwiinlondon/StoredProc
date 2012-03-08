USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[DealingDateDefinition_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[DealingDateDefinition_Insert]
GO

CREATE PROCEDURE DBO.[DealingDateDefinition_Insert]
		@Name varchar(100), 
		@PeriodicityId int, 
		@CutOffTime time, 
		@CutOffDaysPrior int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into DealingDateDefinition
			(Name, PeriodicityId, CutOffTime, CutOffDaysPrior, UpdateUserID, StartDt)
	VALUES
			(@Name, @PeriodicityId, @CutOffTime, @CutOffDaysPrior, @UpdateUserID, @StartDt)

	SELECT	DealingDateDefinitionId, StartDt, DataVersion
	FROM	DealingDateDefinition
	WHERE	DealingDateDefinitionId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
