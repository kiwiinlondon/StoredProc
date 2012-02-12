USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[BloombergYellowKey_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[BloombergYellowKey_Delete]
GO

CREATE PROCEDURE DBO.[BloombergYellowKey_Delete]
		@BloombergYellowKeyId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO BloombergYellowKey_hst (
			BloombergYellowKeyId, Name, StartDt, UpdateUserID, DataVersion, Code, EndDt, LastActionUserID)
	SELECT	BloombergYellowKeyId, Name, StartDt, UpdateUserID, DataVersion, Code, @EndDt, @UpdateUserID
	FROM	BloombergYellowKey
	WHERE	BloombergYellowKeyId = @BloombergYellowKeyId

	DELETE	BloombergYellowKey
	WHERE	BloombergYellowKeyId = @BloombergYellowKeyId
	AND		DataVersion = @DataVersion
GO
