USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[BloombergYellowKey_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[BloombergYellowKey_Update]
GO

CREATE PROCEDURE DBO.[BloombergYellowKey_Update]
		@BloombergYellowKeyId int, 
		@Name varchar(200), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@Code varchar(10)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO BloombergYellowKey_hst (
			BloombergYellowKeyId, Name, StartDt, UpdateUserID, DataVersion, Code, EndDt, LastActionUserID)
	SELECT	BloombergYellowKeyId, Name, StartDt, UpdateUserID, DataVersion, Code, @StartDt, @UpdateUserID
	FROM	BloombergYellowKey
	WHERE	BloombergYellowKeyId = @BloombergYellowKeyId

	UPDATE	BloombergYellowKey
	SET		Name = @Name, UpdateUserID = @UpdateUserID, Code = @Code,  StartDt = @StartDt
	WHERE	BloombergYellowKeyId = @BloombergYellowKeyId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	BloombergYellowKey
	WHERE	BloombergYellowKeyId = @BloombergYellowKeyId
	AND		@@ROWCOUNT > 0

GO
