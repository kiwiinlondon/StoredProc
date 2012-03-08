USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[DealingDateDefinition_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[DealingDateDefinition_Update]
GO

CREATE PROCEDURE DBO.[DealingDateDefinition_Update]
		@DealingDateDefinitionId int, 
		@Name varchar(100), 
		@PeriodicityId int, 
		@CutOffTime time, 
		@CutOffDaysPrior int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO DealingDateDefinition_hst (
			DealingDateDefinitionId, Name, PeriodicityId, CutOffTime, CutOffDaysPrior, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	DealingDateDefinitionId, Name, PeriodicityId, CutOffTime, CutOffDaysPrior, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	DealingDateDefinition
	WHERE	DealingDateDefinitionId = @DealingDateDefinitionId

	UPDATE	DealingDateDefinition
	SET		Name = @Name, PeriodicityId = @PeriodicityId, CutOffTime = @CutOffTime, CutOffDaysPrior = @CutOffDaysPrior, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	DealingDateDefinitionId = @DealingDateDefinitionId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	DealingDateDefinition
	WHERE	DealingDateDefinitionId = @DealingDateDefinitionId
	AND		@@ROWCOUNT > 0

GO
