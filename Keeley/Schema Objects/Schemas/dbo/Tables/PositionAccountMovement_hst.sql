USE Keeley

create table DBO.PositionAccountMovement_hst(
	PositionAccountMovementID int not null,
	InternalAllocationID int not null,
	PositionAccountID int not null,
	Quantity numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)