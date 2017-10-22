USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AdditionalFundIndex_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AdditionalFundIndex_Insert]
GO

CREATE PROCEDURE DBO.[AdditionalFundIndex_Insert]
		@FundId int, 
		@IndexId int, 
		@FundIndexTypeId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into AdditionalFundIndex
			(FundId, IndexId, FundIndexTypeId, UpdateUserID, StartDt)
	VALUES
			(@FundId, @IndexId, @FundIndexTypeId, @UpdateUserID, @StartDt)

	SELECT	AdditionalFundIndexId, StartDt, DataVersion
	FROM	AdditionalFundIndex
	WHERE	AdditionalFundIndexId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
