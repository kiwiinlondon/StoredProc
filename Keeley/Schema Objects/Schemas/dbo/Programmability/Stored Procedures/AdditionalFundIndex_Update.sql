USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AdditionalFundIndex_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AdditionalFundIndex_Update]
GO

CREATE PROCEDURE DBO.[AdditionalFundIndex_Update]
		@AdditionalFundIndexId int, 
		@FundId int, 
		@IndexId int, 
		@FundIndexTypeId int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO AdditionalFundIndex_hst (
			AdditionalFundIndexId, FundId, IndexId, FundIndexTypeId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	AdditionalFundIndexId, FundId, IndexId, FundIndexTypeId, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	AdditionalFundIndex
	WHERE	AdditionalFundIndexId = @AdditionalFundIndexId

	UPDATE	AdditionalFundIndex
	SET		FundId = @FundId, IndexId = @IndexId, FundIndexTypeId = @FundIndexTypeId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	AdditionalFundIndexId = @AdditionalFundIndexId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	AdditionalFundIndex
	WHERE	AdditionalFundIndexId = @AdditionalFundIndexId
	AND		@@ROWCOUNT > 0

GO
