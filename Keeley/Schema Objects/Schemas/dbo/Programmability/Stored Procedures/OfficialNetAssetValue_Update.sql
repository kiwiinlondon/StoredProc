USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[OfficialNetAssetValue_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[OfficialNetAssetValue_Update]
GO

CREATE PROCEDURE DBO.[OfficialNetAssetValue_Update]
		@OfficialNetAssetValueId int, 
		@FundId int, 
		@ReferenceDate datetime, 
		@Value numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO OfficialNetAssetValue_hst (
			OfficialNetAssetValueId, FundId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	OfficialNetAssetValueId, FundId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	OfficialNetAssetValue
	WHERE	OfficialNetAssetValueId = @OfficialNetAssetValueId

	UPDATE	OfficialNetAssetValue
	SET		FundId = @FundId, ReferenceDate = @ReferenceDate, Value = @Value, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	OfficialNetAssetValueId = @OfficialNetAssetValueId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	OfficialNetAssetValue
	WHERE	OfficialNetAssetValueId = @OfficialNetAssetValueId
	AND		@@ROWCOUNT > 0

GO
