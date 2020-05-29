﻿USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RawFinancingType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RawFinancingType_Insert]
GO

CREATE PROCEDURE DBO.[RawFinancingType_Insert]
		@Name varchar(50), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into RawFinancingType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	RawFinancingTypeId, StartDt, DataVersion
	FROM	RawFinancingType
	WHERE	RawFinancingTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
