USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[OfficialNetAssetValue_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[OfficialNetAssetValue_Delete]
GO

CREATE PROCEDURE DBO.[OfficialNetAssetValue_Delete]
		@OfficialNetAssetValueId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO OfficialNetAssetValue_hst (
			OfficialNetAssetValueId, FundId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, InSpecieTransfer, EndDt, LastActionUserID)
	SELECT	OfficialNetAssetValueId, FundId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, InSpecieTransfer, @EndDt, @UpdateUserID
	FROM	OfficialNetAssetValue
	WHERE	OfficialNetAssetValueId = @OfficialNetAssetValueId

	DELETE	OfficialNetAssetValue
	WHERE	OfficialNetAssetValueId = @OfficialNetAssetValueId
	AND		DataVersion = @DataVersion
GO
