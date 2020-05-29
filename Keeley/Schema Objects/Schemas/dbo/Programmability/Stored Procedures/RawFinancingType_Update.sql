USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RawFinancingType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RawFinancingType_Update]
GO

CREATE PROCEDURE DBO.[RawFinancingType_Update]
		@RawFinancingTypeId int, 
		@Name varchar(50), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO RawFinancingType_hst (
			RawFinancingTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	RawFinancingTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	RawFinancingType
	WHERE	RawFinancingTypeId = @RawFinancingTypeId

	UPDATE	RawFinancingType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	RawFinancingTypeId = @RawFinancingTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	RawFinancingType
	WHERE	RawFinancingTypeId = @RawFinancingTypeId
	AND		@@ROWCOUNT > 0

GO
