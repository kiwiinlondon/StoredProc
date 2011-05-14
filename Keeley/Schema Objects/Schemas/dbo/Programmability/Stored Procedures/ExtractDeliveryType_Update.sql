USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractDeliveryType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractDeliveryType_Update]
GO

CREATE PROCEDURE DBO.[ExtractDeliveryType_Update]
		@ExtractDeliveryTypeID int, 
		@Name varchar(70), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ExtractDeliveryType_hst (
			ExtractDeliveryTypeID, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractDeliveryTypeID, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ExtractDeliveryType
	WHERE	ExtractDeliveryTypeID = @ExtractDeliveryTypeID

	UPDATE	ExtractDeliveryType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ExtractDeliveryTypeID = @ExtractDeliveryTypeID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ExtractDeliveryType
	WHERE	ExtractDeliveryTypeID = @ExtractDeliveryTypeID
	AND		@@ROWCOUNT > 0

GO
