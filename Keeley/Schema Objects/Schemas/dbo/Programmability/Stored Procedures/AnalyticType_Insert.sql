USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AnalyticType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AnalyticType_Insert]
GO

CREATE PROCEDURE DBO.[AnalyticType_Insert]
		@Name varchar(100), 
		@UpdateUserID int, 
		@FMValueSpecId int, 
		@BloombergMnemonic varchar(100)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into AnalyticType
			(Name, UpdateUserID, FMValueSpecId, BloombergMnemonic, StartDt)
	VALUES
			(@Name, @UpdateUserID, @FMValueSpecId, @BloombergMnemonic, @StartDt)

	SELECT	AnalyticTypeId, StartDt, DataVersion
	FROM	AnalyticType
	WHERE	AnalyticTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
