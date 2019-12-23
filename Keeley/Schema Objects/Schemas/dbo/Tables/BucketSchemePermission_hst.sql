USE Keeley

create table DBO.BucketSchemePermission_hst(
	BucketSchemePermissionId int not null,
	BucketSchemeId int not null,
	IsEditable bit,
	ApplicationUserId int,
	ADGroupName varchar(250),
	StartDt datetime,
	UpdateUserID int,
	DataVersion binary(8),
	EndDt datetime,
	LastActionUserID int)