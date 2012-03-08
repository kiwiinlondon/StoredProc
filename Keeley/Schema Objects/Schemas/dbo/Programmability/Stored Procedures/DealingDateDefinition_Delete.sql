USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[DealingDateDefinition_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[DealingDateDefinition_Delete]
GO

CREATE PROCEDURE DBO.[DealingDateDefinition_Delete]
		@DealingDateDefinitionId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO DealingDateDefinition_hst (
			DealingDateDefinitionId, Name, PeriodicityId, CutOffTime, CutOffDaysPrior, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	DealingDateDefinitionId, Name, PeriodicityId, CutOffTime, CutOffDaysPrior, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	DealingDateDefinition
	WHERE	DealingDateDefinitionId = @DealingDateDefinitionId

	DELETE	DealingDateDefinition
	WHERE	DealingDateDefinitionId = @DealingDateDefinitionId
	AND		DataVersion = @DataVersion
GO
