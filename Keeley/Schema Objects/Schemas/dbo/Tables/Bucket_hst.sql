USE Keeley

create table DBO.Bucket_hst(
	BucketId int not null,
	BucketSchemeId int not null,
	Name varchar(50) not null,
	IsDefaultBucket bit not null,
	LimitValue numeric(28,16),
	IsLimitInclusive bit,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)