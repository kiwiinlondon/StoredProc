USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TempFundAndIndexPrice_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TempFundAndIndexPrice_Insert]
GO

CREATE PROCEDURE DBO.[TempFundAndIndexPrice_Insert]
		@InstrumentMarketId int, 
		@ReferenceDate datetime, 
		@Value numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into TempFundAndIndexPrice
			(InstrumentMarketId, ReferenceDate, Value, StartDt)
	VALUES
			(@InstrumentMarketId, @ReferenceDate, @Value, @StartDt)

	SELECT	PriceId, StartDt, DataVersion
	FROM	TempFundAndIndexPrice
	WHERE	PriceId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
