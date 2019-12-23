USE Keeley

create table DBO.BucketValue_hst(
	BucketValueId int not null,
	BucketId int not null,
	EntityId int,
	EntityId2 int,
	NumericValue numeric(28,16),
	TextValue varchar(50),
	StartDt datetime not null,
	DataVersion binary(8) not null,
	UpdateUserID int not null,
	EndDt datetime,
	LastActionUserID int)