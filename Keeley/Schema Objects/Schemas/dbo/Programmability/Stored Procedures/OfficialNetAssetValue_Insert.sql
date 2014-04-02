﻿USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[OfficialNetAssetValue_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[OfficialNetAssetValue_Insert]
GO

CREATE PROCEDURE DBO.[OfficialNetAssetValue_Insert]
		@FundId int, 
		@ReferenceDate datetime, 
		@Value numeric(27,8), 
		@UpdateUserID int, 
		@InSpecieTransfer numeric(27,8), 
		@UnitsInIssue numeric(27,8), 
		@GrossAssetValue numeric(27,8), 
		@TodayManagementFee numeric(27,8), 
		@ValueIsForReferenceDate bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into OfficialNetAssetValue
			(FundId, ReferenceDate, Value, UpdateUserID, InSpecieTransfer, UnitsInIssue, GrossAssetValue, TodayManagementFee, ValueIsForReferenceDate, StartDt)
	VALUES
			(@FundId, @ReferenceDate, @Value, @UpdateUserID, @InSpecieTransfer, @UnitsInIssue, @GrossAssetValue, @TodayManagementFee, @ValueIsForReferenceDate, @StartDt)

	SELECT	OfficialNetAssetValueId, StartDt, DataVersion
	FROM	OfficialNetAssetValue
	WHERE	OfficialNetAssetValueId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
