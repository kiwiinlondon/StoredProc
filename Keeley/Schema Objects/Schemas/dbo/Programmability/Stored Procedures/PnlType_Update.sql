USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PnlType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PnlType_Update]
GO

CREATE PROCEDURE DBO.[PnlType_Update]
		@PnlTypeId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@MultiplyByPercentageOfFund bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PnlType_hst (
			PnlTypeId, Name, StartDt, UpdateUserID, DataVersion, MultiplyByPercentageOfFund, EndDt, LastActionUserID)
	SELECT	PnlTypeId, Name, StartDt, UpdateUserID, DataVersion, MultiplyByPercentageOfFund, @StartDt, @UpdateUserID
	FROM	PnlType
	WHERE	PnlTypeId = @PnlTypeId

	UPDATE	PnlType
	SET		Name = @Name, UpdateUserID = @UpdateUserID, MultiplyByPercentageOfFund = @MultiplyByPercentageOfFund,  StartDt = @StartDt
	WHERE	PnlTypeId = @PnlTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PnlType
	WHERE	PnlTypeId = @PnlTypeId
	AND		@@ROWCOUNT > 0

GO
