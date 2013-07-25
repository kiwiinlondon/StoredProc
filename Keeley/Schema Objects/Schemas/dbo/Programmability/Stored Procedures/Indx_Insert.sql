USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Indx_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Indx_Insert]
GO

CREATE PROCEDURE DBO.[Indx_Insert]
		@InstrumentMarketId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Indx
			(InstrumentMarketId, UpdateUserID, StartDt)
	VALUES
			(@InstrumentMarketId, @UpdateUserID, @StartDt)

	SELECT	InstrumentMarketId, StartDt, DataVersion
	FROM	Indx
	WHERE	InstrumentMarketId = @InstrumentMarketId
	AND		@@ROWCOUNT > 0

GO