USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientTrail_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientTrail_Insert]
GO

CREATE PROCEDURE DBO.[ClientTrail_Insert]
		@ClientAccountId int, 
		@FundId int, 
		@Rate numeric(27,8), 
		@Quantity numeric(27,8), 
		@EffectiveStartDate datetime, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ClientTrail
			(ClientAccountId, FundId, Rate, Quantity, EffectiveStartDate, UpdateUserID, StartDt)
	VALUES
			(@ClientAccountId, @FundId, @Rate, @Quantity, @EffectiveStartDate, @UpdateUserID, @StartDt)

	SELECT	ClientTrailId, StartDt, DataVersion
	FROM	ClientTrail
	WHERE	ClientTrailId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
