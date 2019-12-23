USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientTradeType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientTradeType_Delete]
GO

CREATE PROCEDURE DBO.[ClientTradeType_Delete]
		@ClientTradeTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ClientTradeType_hst (
			ClientTradeTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ClientTradeTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ClientTradeType
	WHERE	ClientTradeTypeId = @ClientTradeTypeId

	DELETE	ClientTradeType
	WHERE	ClientTradeTypeId = @ClientTradeTypeId
	AND		DataVersion = @DataVersion
GO
