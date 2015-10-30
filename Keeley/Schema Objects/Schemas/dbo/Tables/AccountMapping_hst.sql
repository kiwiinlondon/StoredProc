USE Keeley

create table DBO.AccountMapping_hst(
	AccountMappingId int not null,
	Name varchar(100) not null,
	FundId int,
	CounterpartyId int,
	InstrumentClassId int,
	AccountIdToMap int,
	AccountId int not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	ApplyToInstrumentOnly bit not null,
	CountryId int,
	MarketId int,
	SendAlertOnly bit not null,
	EndDt datetime,
	LastActionUserID int)