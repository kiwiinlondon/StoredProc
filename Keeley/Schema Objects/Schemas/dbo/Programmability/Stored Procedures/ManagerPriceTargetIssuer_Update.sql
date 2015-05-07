USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ManagerPriceTargetIssuer_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ManagerPriceTargetIssuer_Update]
GO

CREATE PROCEDURE DBO.[ManagerPriceTargetIssuer_Update]
		@ManagerPriceTargetIssuerId int, 
		@ManagerId int, 
		@IssuerId int, 
		@StopLossPrice numeric(27,8), 
		@TargetPrice numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ManagerPriceTargetIssuer_hst (
			ManagerPriceTargetIssuerId, ManagerId, IssuerId, StopLossPrice, TargetPrice, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ManagerPriceTargetIssuerId, ManagerId, IssuerId, StopLossPrice, TargetPrice, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ManagerPriceTargetIssuer
	WHERE	ManagerPriceTargetIssuerId = @ManagerPriceTargetIssuerId

	UPDATE	ManagerPriceTargetIssuer
	SET		ManagerId = @ManagerId, IssuerId = @IssuerId, StopLossPrice = @StopLossPrice, TargetPrice = @TargetPrice, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ManagerPriceTargetIssuerId = @ManagerPriceTargetIssuerId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ManagerPriceTargetIssuer
	WHERE	ManagerPriceTargetIssuerId = @ManagerPriceTargetIssuerId
	AND		@@ROWCOUNT > 0

GO
