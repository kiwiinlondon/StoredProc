USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[DisclosureRuleInstrument_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[DisclosureRuleInstrument_Update]
GO

CREATE PROCEDURE DBO.[DisclosureRuleInstrument_Update]
		@DisclosureRuleInstrumentId int, 
		@DisclosureRuleId int, 
		@Exclude bit, 
		@CountryId int, 
		@InstrumentMarketId int, 
		@InstrumentClassId int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO DisclosureRuleInstrument_hst (
			DisclosureRuleInstrumentId, DisclosureRuleId, Exclude, CountryId, InstrumentMarketId, InstrumentClassId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	DisclosureRuleInstrumentId, DisclosureRuleId, Exclude, CountryId, InstrumentMarketId, InstrumentClassId, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	DisclosureRuleInstrument
	WHERE	DisclosureRuleInstrumentId = @DisclosureRuleInstrumentId

	UPDATE	DisclosureRuleInstrument
	SET		DisclosureRuleId = @DisclosureRuleId, Exclude = @Exclude, CountryId = @CountryId, InstrumentMarketId = @InstrumentMarketId, InstrumentClassId = @InstrumentClassId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	DisclosureRuleInstrumentId = @DisclosureRuleInstrumentId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	DisclosureRuleInstrument
	WHERE	DisclosureRuleInstrumentId = @DisclosureRuleInstrumentId
	AND		@@ROWCOUNT > 0

GO
