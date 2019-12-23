USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractDeliveryType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractDeliveryType_Insert]
GO

CREATE PROCEDURE DBO.[ExtractDeliveryType_Insert]
		@Name varchar(70), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ExtractDeliveryType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	ExtractDeliveryTypeID, StartDt, DataVersion
	FROM	ExtractDeliveryType
	WHERE	ExtractDeliveryTypeID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
