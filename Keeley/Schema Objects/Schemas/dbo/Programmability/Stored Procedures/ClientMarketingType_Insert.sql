USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientMarketingType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientMarketingType_Insert]
GO

CREATE PROCEDURE DBO.[ClientMarketingType_Insert]
		@Name varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ClientMarketingType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	ClientMarketingTypeId, StartDt, DataVersion
	FROM	ClientMarketingType
	WHERE	ClientMarketingTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
