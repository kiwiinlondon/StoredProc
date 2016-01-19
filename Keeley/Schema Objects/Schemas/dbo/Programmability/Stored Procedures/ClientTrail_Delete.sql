USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientTrail_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientTrail_Delete]
GO

CREATE PROCEDURE DBO.[ClientTrail_Delete]
		@ClientTrailId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ClientTrail_hst (
			ClientTrailId, ClientAccountId, FundId, Rate, Quantity, EffectiveStartDate, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ClientTrailId, ClientAccountId, FundId, Rate, Quantity, EffectiveStartDate, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ClientTrail
	WHERE	ClientTrailId = @ClientTrailId

	DELETE	ClientTrail
	WHERE	ClientTrailId = @ClientTrailId
	AND		DataVersion = @DataVersion
GO
