USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AdditionalFundIndex_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AdditionalFundIndex_Delete]
GO

CREATE PROCEDURE DBO.[AdditionalFundIndex_Delete]
		@AdditionalFundIndexId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO AdditionalFundIndex_hst (
			AdditionalFundIndexId, FundId, IndexId, FundIndexTypeId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	AdditionalFundIndexId, FundId, IndexId, FundIndexTypeId, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	AdditionalFundIndex
	WHERE	AdditionalFundIndexId = @AdditionalFundIndexId

	DELETE	AdditionalFundIndex
	WHERE	AdditionalFundIndexId = @AdditionalFundIndexId
	AND		DataVersion = @DataVersion
GO
