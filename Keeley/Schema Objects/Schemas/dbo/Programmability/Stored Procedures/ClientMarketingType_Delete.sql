USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientMarketingType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientMarketingType_Delete]
GO

CREATE PROCEDURE DBO.[ClientMarketingType_Delete]
		@ClientMarketingTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ClientMarketingType_hst (
			ClientMarketingTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ClientMarketingTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ClientMarketingType
	WHERE	ClientMarketingTypeId = @ClientMarketingTypeId

	DELETE	ClientMarketingType
	WHERE	ClientMarketingTypeId = @ClientMarketingTypeId
	AND		DataVersion = @DataVersion
GO
