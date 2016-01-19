USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientTrail_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientTrail_Update]
GO

CREATE PROCEDURE DBO.[ClientTrail_Update]
		@ClientTrailId int, 
		@ClientAccountId int, 
		@FundId int, 
		@Rate numeric(27,8), 
		@Quantity numeric(27,8), 
		@EffectiveStartDate datetime, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ClientTrail_hst (
			ClientTrailId, ClientAccountId, FundId, Rate, Quantity, EffectiveStartDate, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ClientTrailId, ClientAccountId, FundId, Rate, Quantity, EffectiveStartDate, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ClientTrail
	WHERE	ClientTrailId = @ClientTrailId

	UPDATE	ClientTrail
	SET		ClientAccountId = @ClientAccountId, FundId = @FundId, Rate = @Rate, Quantity = @Quantity, EffectiveStartDate = @EffectiveStartDate, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ClientTrailId = @ClientTrailId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ClientTrail
	WHERE	ClientTrailId = @ClientTrailId
	AND		@@ROWCOUNT > 0

GO
