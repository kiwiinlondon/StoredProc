USE Keeley

create table DBO.BucketScheme_hst(
	BucketSchemeId int not null,
	Name varchar(250) not null,
	Description varchar(1000),
	EntityTypeId int,
	EntityTypeId2 int,
	TypeCodeId int not null,
	OwnerApplicationUserId int not null,
	UpdateUserID int not null,
	StartDt datetime not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)