USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ManagerPriceTargetIssuer_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ManagerPriceTargetIssuer_Insert]
GO

CREATE PROCEDURE DBO.[ManagerPriceTargetIssuer_Insert]
		@ManagerId int, 
		@IssuerId int, 
		@StopLossPrice numeric(27,8), 
		@TargetPrice numeric(27,8), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ManagerPriceTargetIssuer
			(ManagerId, IssuerId, StopLossPrice, TargetPrice, UpdateUserID, StartDt)
	VALUES
			(@ManagerId, @IssuerId, @StopLossPrice, @TargetPrice, @UpdateUserID, @StartDt)

	SELECT	ManagerPriceTargetIssuerId, StartDt, DataVersion
	FROM	ManagerPriceTargetIssuer
	WHERE	ManagerPriceTargetIssuerId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
