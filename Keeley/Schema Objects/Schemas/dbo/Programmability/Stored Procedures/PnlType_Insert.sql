USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PnlType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PnlType_Insert]
GO

CREATE PROCEDURE DBO.[PnlType_Insert]
		@Name varchar(100), 
		@UpdateUserID int, 
		@MultiplyByPercentageOfFund bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PnlType
			(Name, UpdateUserID, MultiplyByPercentageOfFund, StartDt)
	VALUES
			(@Name, @UpdateUserID, @MultiplyByPercentageOfFund, @StartDt)

	SELECT	PnlTypeId, StartDt, DataVersion
	FROM	PnlType
	WHERE	PnlTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
