USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FinancingType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FinancingType_Delete]
GO

CREATE PROCEDURE DBO.[FinancingType_Delete]
		@FinancingTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FinancingType_hst (
			FinancingTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FinancingTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	FinancingType
	WHERE	FinancingTypeId = @FinancingTypeId

	DELETE	FinancingType
	WHERE	FinancingTypeId = @FinancingTypeId
	AND		DataVersion = @DataVersion
GO
