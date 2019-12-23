USE Keeley

create table DBO.Indx_hst(
	InstrumentMarketId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	IndexTypeId int not null,
	CollectWeights bit not null,
	ConstituentsExist bit not null,
	EndDt datetime,
	LastActionUserID int)