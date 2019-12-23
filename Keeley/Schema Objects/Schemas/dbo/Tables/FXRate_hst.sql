USE Keeley

create table DBO.FXRate_hst(
	FXRateId int not null,
	FromCurrencyId int not null,
	ToCurrencyId int not null,
	ReferenceDate datetime not null,
	EntityRankingSchemeId int not null,
	ForwardDate datetime not null,
	Value numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	FromRawFXRateId int,
	ToRawFXRateId int not null,
	FromSecondRawFXRateId int,
	ToSecondRawFXRateId int,
	EndDt datetime,
	LastActionUserID int)