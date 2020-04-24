USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[MessageQueue_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[MessageQueue_Insert]
GO

CREATE PROCEDURE DBO.[MessageQueue_Insert]
		@MessageTypeId int, 
		@Message varchar(512), 
		@ChangeType char, 
		@MessageSource varchar(50), 
		@FundId int, 
		@AttributionSourceId int, 
		@ReferenceDate datetime, 
		@CurrencyId int, 
		@PositionId int, 
		@PnlTypeId int, 
		@CounterpartyId int, 
		@AttributionPnlId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into MessageQueue
			(MessageTypeId, Message, ChangeType, MessageSource, FundId, AttributionSourceId, ReferenceDate, CurrencyId, PositionId, PnlTypeId, CounterpartyId, AttributionPnlId, StartDt)
	VALUES
			(@MessageTypeId, @Message, @ChangeType, @MessageSource, @FundId, @AttributionSourceId, @ReferenceDate, @CurrencyId, @PositionId, @PnlTypeId, @CounterpartyId, @AttributionPnlId, @StartDt)

	SELECT	MessageId, StartDt, DataVersion
	FROM	MessageQueue
	WHERE	MessageId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
