USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[DisclosureRuleInstrument_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[DisclosureRuleInstrument_Insert]
GO

CREATE PROCEDURE DBO.[DisclosureRuleInstrument_Insert]
		@DisclosureRuleId int, 
		@Exclude bit, 
		@CountryId int, 
		@InstrumentMarketId int, 
		@InstrumentClassId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into DisclosureRuleInstrument
			(DisclosureRuleId, Exclude, CountryId, InstrumentMarketId, InstrumentClassId, UpdateUserID, StartDt)
	VALUES
			(@DisclosureRuleId, @Exclude, @CountryId, @InstrumentMarketId, @InstrumentClassId, @UpdateUserID, @StartDt)

	SELECT	DisclosureRuleInstrumentId, StartDt, DataVersion
	FROM	DisclosureRuleInstrument
	WHERE	DisclosureRuleInstrumentId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
