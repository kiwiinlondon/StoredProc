USE Keeley

create table DBO.EntityProperty_hst(
	EntityPropertyID int not null,
	EntityTypeId int not null,
	NeedsToBeCalculated bit not null,
	Name varchar(100) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	PropertyOnChildEntity bit,
	TypeCode int not null,
	IdentifierTypeId int,
	IsPrimaryKey bit not null,
	LookupEntityTypeId int,
	InputEntityPropertyIds varchar(100),
	IsFXRate bit not null,
	CanHaveFXRateApplied bit not null,
	EndDt datetime,
	LastActionUserID int)