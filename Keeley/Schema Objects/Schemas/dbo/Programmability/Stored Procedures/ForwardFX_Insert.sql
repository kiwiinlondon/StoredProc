USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ForwardFX_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ForwardFX_Insert]
GO

CREATE PROCEDURE DBO.[ForwardFX_Insert]
		@InstrumentId int, 
		@BaseCurrencyId int, 
		@ContraCurrencyId int, 
		@IsProp bit, 
		@MaturityDate datetime, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ForwardFX
			(InstrumentId, BaseCurrencyId, ContraCurrencyId, IsProp, MaturityDate, UpdateUserID, StartDt)
	VALUES
			(@InstrumentId, @BaseCurrencyId, @ContraCurrencyId, @IsProp, @MaturityDate, @UpdateUserID, @StartDt)

	SELECT	InstrumentId, StartDt, DataVersion
	FROM	ForwardFX
	WHERE	InstrumentId = @InstrumentId
	AND		@@ROWCOUNT > 0

GO
