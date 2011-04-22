USE Keeley

create table DBO.EntityProperty_hst(
	EntityPropertyID int not null,
	EntityTypeId int not null,
	NeedsToBeCalculated bit not null,
	Name varchar(70) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	PropertyOnChildEntity bit not null,
	EndDt datetime,
	LastActionUserID int)