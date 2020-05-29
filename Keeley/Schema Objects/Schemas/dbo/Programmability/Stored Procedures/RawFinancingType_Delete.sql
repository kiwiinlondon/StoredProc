USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RawFinancingType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RawFinancingType_Delete]
GO

CREATE PROCEDURE DBO.[RawFinancingType_Delete]
		@RawFinancingTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO RawFinancingType_hst (
			RawFinancingTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	RawFinancingTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	RawFinancingType
	WHERE	RawFinancingTypeId = @RawFinancingTypeId

	DELETE	RawFinancingType
	WHERE	RawFinancingTypeId = @RawFinancingTypeId
	AND		DataVersion = @DataVersion
GO
