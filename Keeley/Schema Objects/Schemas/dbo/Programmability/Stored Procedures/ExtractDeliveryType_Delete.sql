USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractDeliveryType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractDeliveryType_Delete]
GO

CREATE PROCEDURE DBO.[ExtractDeliveryType_Delete]
		@ExtractDeliveryTypeID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ExtractDeliveryType_hst (
			ExtractDeliveryTypeID, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractDeliveryTypeID, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ExtractDeliveryType
	WHERE	ExtractDeliveryTypeID = @ExtractDeliveryTypeID

	DELETE	ExtractDeliveryType
	WHERE	ExtractDeliveryTypeID = @ExtractDeliveryTypeID
	AND		DataVersion = @DataVersion
GO
