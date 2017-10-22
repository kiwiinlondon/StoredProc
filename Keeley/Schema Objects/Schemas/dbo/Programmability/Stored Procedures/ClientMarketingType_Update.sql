USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientMarketingType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientMarketingType_Update]
GO

CREATE PROCEDURE DBO.[ClientMarketingType_Update]
		@ClientMarketingTypeId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ClientMarketingType_hst (
			ClientMarketingTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ClientMarketingTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ClientMarketingType
	WHERE	ClientMarketingTypeId = @ClientMarketingTypeId

	UPDATE	ClientMarketingType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ClientMarketingTypeId = @ClientMarketingTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ClientMarketingType
	WHERE	ClientMarketingTypeId = @ClientMarketingTypeId
	AND		@@ROWCOUNT > 0

GO
