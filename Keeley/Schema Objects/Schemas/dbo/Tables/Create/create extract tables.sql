
CREATE TABLE [dbo].[EntityType](
	[EntityTypeID] [int] IDENTITY(1,1) NOT NULL CONSTRAINT [EntityTypePK] PRIMARY KEY,
	[Name] [varchar](100) NOT NULL,
	[StartDt] [datetime] NOT NULL,
	[UpdateUserID] [int] NOT NULL  CONSTRAINT EntityTypeUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	[DataVersion] [timestamp] NOT NULL)

create unique index [EntityTypeUK] on [EntityType](Name)

create table DBO.EntityProperty (
	EntityPropertyID int identity(1,1) not null CONSTRAINT EntityPropertyPK PRIMARY KEY,
	EntityTypeId int not null  CONSTRAINT EntityPropertyEntityTypeIDFK FOREIGN KEY REFERENCES EntityType(EntityTypeId),
	NeedsToBeCalculated bit not null,
	PropertyOnChildEntity bit not null,	
	IdentifierTypeId int CONSTRAINT EntityPropertyIdentifierTypeIDFK FOREIGN KEY REFERENCES IdentifierType(IdentifierTypeId),
	TypeCode int not null,
	Name varchar(70) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT EntityPropertyUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)	

alter table entityproperty add IdentifierTypeId int CONSTRAINT EntityPropertyIdentifierTypeIDFK FOREIGN KEY REFERENCES IdentifierType(IdentifierTypeId)
select * from ExtractConfiguration
delete from ExtractOutputConfiguration where ExtractOutputConfigurationID = 52
update ExtractOutputConfiguration set format ='{0:F2}' where ExtractOutputConfigurationID = 54
update EntityProperty set identifiertypeid = 2 where EntityPropertyID = 69
update EntityProperty set for = 6 where EntityPropertyID = 70

30

INSERT INTO [Keeley].[dbo].[ExtractConfiguration]
           ([ExtractId]
           ,[ConfigurationKey]
           ,[ConfigurationValue]
           ,[StartDt]
           ,[UpdateUserID])
     VALUES
           (4
           ,'SubjectLookup'
           ,36
           ,GETDATE()
           ,1)
GO

select * from Extract

create unique index EntityPropertyUK on EntityProperty(EntityTypeId,Name)


create table DBO.ExtractType (
	ExtractTypeID int identity(1,1) not null CONSTRAINT ExtractTypePK PRIMARY KEY,
	Name varchar(70) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ExtractTypeUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
	)

create unique index ExtractTypeUK on ExtractType(Name)

create table DBO.ExtractOutputType (
	ExtractOutputTypeID int identity(1,1) not null CONSTRAINT ExtractOutputTypePK PRIMARY KEY,
	Name varchar(70) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ExtractOutputTypeUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
	)
create unique index ExtractOutputTypeUK on ExtractOutputType(Name)

create table DBO.ExtractRunnerType (
	ExtractRunnerTypeID int identity(1,1) not null CONSTRAINT ExtractRunnerTypePK PRIMARY KEY,
	Name varchar(70) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ExtractRunnerTypeUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
	)
create unique index ExtractRunnerTypeTypeUK on ExtractOutputType(Name)

create table DBO.ExtractInputType (
	ExtractInputTypeID int identity(1,1) not null CONSTRAINT ExtractInputTypePK PRIMARY KEY,
	Name varchar(70) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ExtractInputTypeUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
	)
create unique index ExtractInputTypeUK on ExtractInputType(Name)
create table DBO.ExtractDeliveryType (
	ExtractDeliveryTypeID int identity(1,1) not null CONSTRAINT ExtractDeliveryTypePK PRIMARY KEY,
	Name varchar(70) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ExtractDeliveryTypeUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
	)
create unique index ExtractDeliveryTypeUK on ExtractDeliveryType(Name)
create table DBO.Extract (
	ExtractID int identity(1,1) not null CONSTRAINT ExtractPK PRIMARY KEY,
	ExtractTypeId int not null  CONSTRAINT ExtractExtractTypeIdFK FOREIGN KEY REFERENCES ExtractType(ExtractTypeId),
	Name varchar(70) not null, 
	ExtractOutputTypeID  int not null  CONSTRAINT ExtractExtractOutputTypeIDFK FOREIGN KEY REFERENCES ExtractOutputType(ExtractOutputTypeID),
	ExtractRunnerTypeID  int not null  CONSTRAINT ExtractExtractRunnerTypeIDFK FOREIGN KEY REFERENCES ExtractRunnerType(ExtractRunnerTypeID),
	ExtractInputTypeID  int not null  CONSTRAINT ExtractExtractInputTypeIDFK FOREIGN KEY REFERENCES ExtractInputType(ExtractInputTypeID),
	ExtractDeliveryTypeID  int not null  CONSTRAINT ExtractExtractDeliveryTypeIDFK FOREIGN KEY REFERENCES ExtractDeliveryType(ExtractDeliveryTypeID),
	ExtractOutputContainerTypeID  int not null  CONSTRAINT ExtractExtractOutputContainerTypeIDFK FOREIGN KEY REFERENCES ExtractOutputContainerType(ExtractOutputContainerTypeID),
	SendIfEmpty bit not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ExtractUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)	

alter table Extract alter column ExtractOutputContainerTypeID int not null CONSTRAINT ExtractExtractOutputContainerTypeIDFK FOREIGN KEY REFERENCES ExtractOutputContainerType(ExtractOutputContainerTypeID)

update ExtractDeliveryType set name = 'Email'
delete from ExtractDeliveryType where ExtractDeliveryTypeID =2

insert into ExtractConfiguration(ExtractId,ConfigurationKey,ConfigurationValue,StartDt,UpdateUserID)

select 4,ConfigurationKey,ConfigurationValue,GETDATE(),1 from ExtractConfiguration where ExtractId = 1 and ConfigurationKey not in (select ConfigurationKey from ExtractConfiguration where ExtractId = 4) and ExtractConfigurationId not in (1)

update Extract set extractoutputcontainertypeid = 2,ExtractOutputTypeID =3 where ExtractID = 4
select * from extractoutputcontainertype
alter table extractRun add RuntimeParameters varchar(1000) alter column ExtractDeliveryTypeID  int not null CONSTRAINT ExtractExtractDeliveryTypeIDFK FOREIGN KEY REFERENCES ExtractDeliveryType(ExtractDeliveryTypeID)

create table DBO.ExtractOutputContainerType (
	ExtractOutputContainerTypeID int identity(1,1) not null CONSTRAINT ExtractOutputContainerTypePK PRIMARY KEY,
	Name varchar(70) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ExtractOutputContainerTypeUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
	)
create unique index ExtractOutputContainerTypeUK on ExtractOutputContainerType(Name)

INSERT INTO [Keeley].[dbo].[ExtractOutputContainerType]
           ([Name]
           ,[StartDt]
           ,[UpdateUserID])
     VALUES
           ('File'
           ,GETDATE()
           ,1)
INSERT INTO [Keeley].[dbo].[ExtractOutputContainerType]
           ([Name]
           ,[StartDt]
           ,[UpdateUserID])
     VALUES
           ('String'
           ,GETDATE()
           ,1)
select * from position

GO




select * from ExtractDeliveryType 

USE Keeley

create table DBO.ExtractRun_hst(
	ExtractRunId int not null,
	ExtractId int not null,
	RunTime datetime not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	InProgress bit not null,
	NumberRecords int not null,
	FilePath varchar(100),
	RuntimeParameters varchar(1000),
	EndDt datetime,
	LastActionUserID int)

alter table Extract alter column SendIfEmpty bit not null,

update extract set sendifempty = 1
update Extract set ExtractDeliveryTypeID = 1 where ExtractID in ( 1,3)
update ExtractOutputType set Name = 'Delimited' where ExtractOutputTypeID = 2

select * from ExtractDeliveryType
select * from ExtractInputType
update Extract set ExtractOutputTypeID = 3 where ExtractID = 4

INSERT INTO [Keeley].[dbo].[ExtractDeliveryType]
           ([Name]
           ,[StartDt]
           ,[UpdateUserID])
     VALUES
           ('Email with Output in Attached File'
           ,GETDATE()
           ,1)

INSERT INTO [Keeley].[dbo].[ExtractDeliveryType]
           ([Name]
           ,[StartDt]
           ,[UpdateUserID])
     VALUES
           ('Email with Output Embedded in Message'
           ,GETDATE()
           ,1)
GO

delete from ExtractInputType where ExtractInputTypeid = 3

ExtractInputTypeID  int not null  CONSTRAINT ExtractExtractInputTypeIDFK FOREIGN KEY REFERENCES ExtractInputType(ExtractInputTypeID),
	ExtractDeliveryTypeID  int not null  CONSTRAINT ExtractExtractDeliveryTypeIDFK FOREIGN KEY REFERENCES ExtractDeliveryType(ExtractDeliveryTypeID)


create table DBO.ExtractOutputType (
	ExtractOutputTypeID int identity(1,1) not null CONSTRAINT ExtractOutputTypePK PRIMARY KEY,
	Name varchar(70) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ExtractOutputTypeUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
	)
create unique index ExtractUK on ExtractType(Name)

INSERT INTO [Keeley].[dbo].[ExtractRunnerType]
           ([Name]
           ,[StartDt]
           ,[UpdateUserID])
     VALUES
           ('All Funds'
           ,GETDATE()
           ,1)

INSERT INTO [Keeley].[dbo].[ExtractRunnerType]
           ([Name]
           ,[StartDt]
           ,[UpdateUserID])
     VALUES
           ('Standard'
           ,GETDATE()
           ,1)

alter table Extract alter column ExtractRunnerTypeId int not null
set ExtractRunnerTypeId = 2
GO



create table DBO.ExtractConfiguration (
	ExtracttConfigurationID int identity(1,1) not null CONSTRAINT ExtractConfigurationPK PRIMARY KEY,
	ExtractId int not null  CONSTRAINT ExtractConfigurationExtractIdFK FOREIGN KEY REFERENCES Extract(ExtractId),
	ConfigurationKey varchar(100) not null,
	ConfigurationValue varchar(100) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ExtractConfigurationIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)	
create unique index ExtractConfigurationUK on ExtractConfiguration(ExtractId,ConfigurationKey)

create table DBO.ExtractInputConfiguration(
	ExtractFieldConfigurationID int identity(1,1) not null CONSTRAINT ExtractFieldConfigurationPK PRIMARY KEY,
	ExtractId int not null  CONSTRAINT ExtractInputConfigurationExtractIdFK FOREIGN KEY REFERENCES Extract(ExtractId),
	EntityPropertyId int not null  CONSTRAINT ExtractInputConfigurationEntityPropertyIdFK FOREIGN KEY REFERENCES EntityProperty(EntityPropertyId),
	IntValue int ,
	StringValue varchar(1000) ,
	DecimalValue numeric(27,8),
	DateTimeValue DateTime ,
	BitValue bit ,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ExtractFieldConfigurationUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
) 

create unique index ExtractInputConfigurationUK on ExtractInputConfiguration(ExtractId,EntityPropertyId,IntValue,StringValue,DecimalValue,DateTimeValue,BitValue)

create table DBO.ExtractRun (
	ExtractRunId int identity(1,1) not null CONSTRAINT ExtractRunPk PRIMARY KEY,
	ExtractId int not null  CONSTRAINT ExtractRunExtractIdFK FOREIGN KEY REFERENCES Extract(ExtractId),
	RunTime DateTime not null,
	InProgress bit not null,
	NumberRecords int not null,
	FilePath varchar(100),
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ExtractRunUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)	

create unique index ExtractRunUK on ExtractRun(ExtractId,RunTime)

drop table DBO.ExtractOutputConfiguration
create table DBO.ExtractOutputConfiguration(
	ExtractOutputConfigurationID int identity(1,1) not null CONSTRAINT ExtractOutputConfigurationPK PRIMARY KEY,
	ExtractId int not null  CONSTRAINT ExtractFieldOutputConfigurationExtractIdFK FOREIGN KEY REFERENCES Extract(ExtractId),
	EntityPropertyId int not null CONSTRAINT ExtractOutputConfigurationDependantEntityPropertyIdFK FOREIGN KEY REFERENCES EntityProperty(EntityPropertyId),
	EntityPropertyToWriteId int not null CONSTRAINT ExtractOutputConfigurationPrincipalEntityPropertyIdFK FOREIGN KEY REFERENCES EntityProperty(EntityPropertyId),		
	Label varchar(1000),
	Format varchar(1000),
	ChangesCanBeIgnored bit not null,
	OrderBy int not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ExtractFieldOutputConfigurationUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
) 

alter table ExtractOutputConfiguration add Format varchar(1000)

select * from ExtractOutputConfiguration

create unique index ExtractOutputConfigurationUK on ExtractOutputConfiguration(ExtractId,EntityPropertyId,EntityPropertyIdToWrite)
create unique index ExtractOutputConfigurationUK2 on ExtractOutputConfiguration(ExtractId,Orderby)

create table DBO.ExtractEntity(
	ExtractEntityID int identity(1,1) not null CONSTRAINT ExtractEntityPK PRIMARY KEY,
	ExtractId int not null CONSTRAINT ExtractEntityExtractIdFK FOREIGN KEY REFERENCES Extract(ExtractId),
	EntityId int not null,
	EntityTypeId int not null CONSTRAINT ExtractEntityEntityTypeIdFK FOREIGN KEY REFERENCES EntityType(EntityTypeId),
	LastSentInExtractRunId int CONSTRAINT ExtractEntityLastSentInExtractRunIdFK FOREIGN KEY REFERENCES ExtractRun(ExtractRunId),
	IsCancelled bit not null,
	SendInNextRun bit not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ExtractEntityUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
	)
	
create unique index ExtractEntityUK on ExtractEntity(ExtractId,EntityTypeId,EntityId)	
		
create table DBO.ExtractEntityPropertyValue(
	ExtractEntityPropertyValueID  int identity(1,1) not null CONSTRAINT ExtractEntityPropertyValuePK PRIMARY KEY,
	ExtractEntityID int not null  CONSTRAINT ExtractEntityPropertyValueExtractEntityIDFK FOREIGN KEY REFERENCES ExtractEntity(ExtractEntityID),	
	EntityPropertyId int not null  CONSTRAINT ExtractEntityPropertyValueEntityPropertyIdFK FOREIGN KEY REFERENCES EntityProperty(EntityPropertyId),
	PreviousIntValue int ,
	IntValue int ,
	StringValue varchar(1000) ,
	PreviousStringValue varchar(1000) ,
	DecimalValue numeric(27,8),
	PreviousDecimalValue numeric(27,8),
	DateTimeValue DateTime ,
	PreviousDateTimeValue DateTime ,
	BitValue bit ,
	PreviousBitValue bit ,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ExtractEntityPropertyValueUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
) 

create unique index ExtractEntityPropertyValueUK on ExtractEntityPropertyValue(ExtractEntityID,EntityPropertyId)	

select * from EventType

INSERT INTO [Keeley].[dbo].[EntityType]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('Trade Event',GETDATE(),1)
INSERT INTO [Keeley].[dbo].[EntityType]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('Instrument Event',GETDATE(),1)
INSERT INTO [Keeley].[dbo].[EntityType]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('Capital Event',GETDATE(),1)           
INSERT INTO [Keeley].[dbo].[EntityType]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('FX Trade Event',GETDATE(),1)           
INSERT INTO [Keeley].[dbo].[EntityType]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('Internal Accounting Event',GETDATE(),1)           
select * from [EntityType]
INSERT INTO [Keeley].[dbo].[ExtractType]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('Event Extract',GETDATE(),1) 
           
create table DBO.ExtractOutputType (
	ExtractOutputTypeID int identity(1,1) not null CONSTRAINT ExtractOutputTypePK PRIMARY KEY,
	Name varchar(70) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ExtractOutputTypeUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
	)

create table DBO.ExtractOutputContainer (
	ExtractOutputTypeID int identity(1,1) not null CONSTRAINT ExtractOutputContainerPK PRIMARY KEY,
	Name varchar(70) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ExtractOutputContainerUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
	)

create table DBO.ExtractDeliveryMechanism (
	ExtractOutputTypeID int identity(1,1) not null CONSTRAINT ExtractOutputContainerPK PRIMARY KEY,
	Name varchar(70) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ExtractOutputContainerUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
	)

select * from ExtractOutputConfiguration      

INSERT INTO [Keeley].[dbo].[ExtractOutputType]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('Email With Generic CSV File',GETDATE(),1)

select * from LegalEntity where LegalEntityID in (select legalentityId from Counterparty)

update [ExtractConfiguration] set ConfigurationValue = 'CAC_{0:yyyyMMddHHmmss}.csv'
where ExtracttConfigurationId = 2

INSERT INTO [Keeley].[dbo].[ExtractConfiguration]
           ([ExtractId],[ConfigurationKey],[ConfigurationValue],[StartDt],[UpdateUserID])
     VALUES
           (1,'OutputFileNameFormat','CAC_{0:yyyyMMddHHmmss}.csv',GETDATE(),1)



INSERT INTO [Keeley].[dbo].[ExtractConfiguration]
           ([ExtractId],[ConfigurationKey],[ConfigurationValue],[StartDt],[UpdateUserID])
     VALUES
           (1,'OutputFileNameValue','DateTime.Now',GETDATE(),1)

INSERT INTO [Keeley].[dbo].[ExtractConfiguration]
           ([ExtractId],[ConfigurationKey],[ConfigurationValue],[StartDt],[UpdateUserID])
     VALUES
           (1,'OutputDirectory','c:\temp',GETDATE(),1)
GO

private const string OutputFileNameFormatKey = "OutputFileNameFormat";
        private const string OutputFileNameValueKey = "OutputFileNameValue";
        private const string OutputDirectoryKey = "OutputDirectory"
        
update EntityProperty set Name = 'IsoCode' where EntityPropertyId = 29        

select * from ExtractEntity where EntityTypeId =9

select * from [ExtractOutputType]

INSERT INTO [Keeley].[dbo].[ExtractOutputType]
           ([Name]
           ,[StartDt]
           ,[UpdateUserID])
     VALUES
           ('Email With Embedded CSV Reconciliation Output'
           ,GETDATE()
           ,1)
GO

INSERT INTO [Keeley].[dbo].[ExtractType]
           ([Name]
           ,[StartDt]
           ,[UpdateUserID])
     VALUES
           ('Reconciliation'
           ,GetDate()
           ,1)
GO

update extract set name = 'CAC Trade File' where ExtractID = 1

select * from extract

INSERT INTO [Keeley].[dbo].[Extract]
           ([ExtractTypeId]
           ,[Name]
           ,[StartDt]
           ,[UpdateUserID]
           ,[ExtractOutputTypeID]
           ,[ExtractRunnerTypeID])
     VALUES
           (3
           ,'Fund Manager Position Rec - All Funds'
           ,GETDATE()
           ,1
           ,2
           ,1)
           
INSERT INTO [Keeley].[dbo].[ExtractConfiguration]
           ([ExtractId],[ConfigurationKey],[ConfigurationValue],[StartDt],[UpdateUserID])
     VALUES
           (4,'FromAddress','KeeleyReconciliation@odey.com',GETDATE(),1)

INSERT INTO [Keeley].[dbo].[ExtractConfiguration]
           ([ExtractId],[ConfigurationKey],[ConfigurationValue],[StartDt],[UpdateUserID])
     VALUES
           (4,'ToAddress','g.poore@odey.com',GETDATE(),1)

INSERT INTO [Keeley].[dbo].[ExtractConfiguration]
           ([ExtractId],[ConfigurationKey],[ConfigurationValue],[StartDt],[UpdateUserID])
     VALUES
           (4,'FromName','Keeley Reconciliation',GETDATE(),1)
           
INSERT INTO [Keeley].[dbo].[ExtractConfiguration]
           ([ExtractId],[ConfigurationKey],[ConfigurationValue],[StartDt],[UpdateUserID])
     VALUES
           (4,'SubjectFormat','{0} Fund Manager Position Reconciliation',GETDATE(),1)           
           
INSERT INTO [Keeley].[dbo].[ExtractConfiguration]
           ([ExtractId],[ConfigurationKey],[ConfigurationValue],[StartDt],[UpdateUserID])
     VALUES
           (4,'Subject','Runtime 0',GETDATE(),1)                      

INSERT INTO [Keeley].[dbo].[ExtractConfiguration]
           ([ExtractId],[ConfigurationKey],[ConfigurationValue],[StartDt],[UpdateUserID])
     VALUES
           (4,'ReconciliationTypeId','1',GETDATE(),1)   

INSERT INTO [Keeley].[dbo].[ExtractConfiguration]
           ([ExtractId],[ConfigurationKey],[ConfigurationValue],[StartDt],[UpdateUserID])
     VALUES
           (4,'FromDate','DateTime.Now',GETDATE(),1)   

INSERT INTO [Keeley].[dbo].[ExtractConfiguration]
           ([ExtractId],[ConfigurationKey],[ConfigurationValue],[StartDt],[UpdateUserID])
     VALUES
           (4,'NumberOfDays','0',GETDATE(),1)   
GO

ReconciliationTypeId
FromDate
NumberOfDays 0
select * from Portfolio  where ReferenceDate = '11-may-2011'         

PortfolioSettlementDate_roll '31-may-2011',1 

select * from [EntityType]

INSERT INTO [Keeley].[dbo].[EntityType]
           ([Name]
           ,[StartDt]
           ,[UpdateUserID])
     VALUES
           ('Book'
           ,GETDATE()
           ,1)
GO

select * from ExtractConfiguration

INSERT INTO [Keeley].[dbo].[ExtractOutputConfiguration]
           ([ExtractId]
           ,[Label],[ChangesCanBeIgnored],[OrderBy],[StartDt],[UpdateUserID],[EntityPropertyId],[EntityPropertyToWriteId],[Format])
     VALUES
           (4,'Date',0,0,GETDATE(),1,68,68,'{0:dd-MMM-yyyy}')

INSERT INTO [Keeley].[dbo].[ExtractOutputConfiguration]
           ([ExtractId]
           ,[Label],[ChangesCanBeIgnored],[OrderBy],[StartDt],[UpdateUserID],[EntityPropertyId],[EntityPropertyToWriteId],[Format])
     VALUES
           (4,'Book',0,1,GETDATE(),1,69,73,null)

INSERT INTO [Keeley].[dbo].[ExtractOutputConfiguration]
           ([ExtractId]
           ,[Label],[ChangesCanBeIgnored],[OrderBy],[StartDt],[UpdateUserID],[EntityPropertyId],[EntityPropertyToWriteId],[Format])
     VALUES
           (4,'FMSecId',0,2,GETDATE(),1,70,70,null)

INSERT INTO [Keeley].[dbo].[ExtractOutputConfiguration]
           ([ExtractId]
           ,[Label],[ChangesCanBeIgnored],[OrderBy],[StartDt],[UpdateUserID],[EntityPropertyId],[EntityPropertyToWriteId],[Format])
     VALUES
           (4,'Security',0,3,GETDATE(),1,70,32,null)

INSERT INTO [Keeley].[dbo].[ExtractOutputConfiguration]
           ([ExtractId]
           ,[Label],[ChangesCanBeIgnored],[OrderBy],[StartDt],[UpdateUserID],[EntityPropertyId],[EntityPropertyToWriteId],[Format])
     VALUES
           (4,'Currency',0,4,GETDATE(),1,71,71,null)

INSERT INTO [Keeley].[dbo].[ExtractOutputConfiguration]
           ([ExtractId]
           ,[Label],[ChangesCanBeIgnored],[OrderBy],[StartDt],[UpdateUserID],[EntityPropertyId],[EntityPropertyToWriteId],[Format])
     VALUES
           (4,'Position',0,5,GETDATE(),1,72,72,null)

GO

INSERT INTO [Keeley].[dbo].[EntityProperty]
           ([EntityTypeId],[NeedsToBeCalculated],[Name],[StartDt],[UpdateUserID],[PropertyOnChildEntity],[TypeCode])
     VALUES
           (20,0,'ReferenceDate',GETDATE(),1,0,16)
INSERT INTO [Keeley].[dbo].[EntityProperty]
           ([EntityTypeId],[NeedsToBeCalculated],[Name],[StartDt],[UpdateUserID],[PropertyOnChildEntity],[TypeCode])
     VALUES
           (20,0,'FMBookId',GETDATE(),1,0,9)           

INSERT INTO [Keeley].[dbo].[EntityProperty]
           ([EntityTypeId],[NeedsToBeCalculated],[Name],[StartDt],[UpdateUserID],[PropertyOnChildEntity],[TypeCode])
     VALUES
           (20,0,'FMSecId',GETDATE(),1,0,9)           

INSERT INTO [Keeley].[dbo].[EntityProperty]
           ([EntityTypeId],[NeedsToBeCalculated],[Name],[StartDt],[UpdateUserID],[PropertyOnChildEntity],[TypeCode])
     VALUES
           (20,0,'CcyIso',GETDATE(),1,0,18)  

INSERT INTO [Keeley].[dbo].[EntityProperty]
           ([EntityTypeId],[NeedsToBeCalculated],[Name],[StartDt],[UpdateUserID],[PropertyOnChildEntity],[TypeCode])
     VALUES
           (20,0,'NetPosition',GETDATE(),1,0,15)  


INSERT INTO [Keeley].[dbo].[EntityProperty]
           ([EntityTypeId],[NeedsToBeCalculated],[Name],[StartDt],[UpdateUserID],[PropertyOnChildEntity],[TypeCode])
     VALUES
           (22,0,'Name',GETDATE(),1,0,18)  


22

select t.Name,p.* from EntityProperty p, EntityType t where p.EntityTypeId = t.EntityTypeID

drop table PortfolioRollDate

CREATE TABLE [dbo].PortfolioRollDate(
	[PortfolioRollDateId] [int] IDENTITY(1,1) NOT NULL CONSTRAINT [PortfolioRollDatePK] PRIMARY KEY,
	[PortfolioAggregationLevelId] [int] NOT NULL  CONSTRAINT PortfolioRollDatePortfolioAggregationLevelIdFK FOREIGN KEY REFERENCES PortfolioAggregationLevel(PortfolioAggregationLevelId),
	[RollDate] [datetime] NOT NULL,
	[StartDt] [datetime] NOT NULL,
	[UpdateUserID] [int] NOT NULL  CONSTRAINT PortfolioRollDateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	[DataVersion] [timestamp] NOT NULL)
	
INSERT INTO [Keeley].[dbo].[PortfolioRollDate]
           ([PortfolioAggregationLevelId]
           ,[RollDate]
           ,[StartDt]
           ,[UpdateUserID])
     VALUES
           (3,
           '12-jun-2011'
           ,GETDATE()
           ,1)
GO

select * from [PortfolioEvent] where ReferenceDate between '24-may-2011' and '25-may-2011' and PortfolioAggregationLevelId = 3

update ExtractConfiguration set ConfigurationValue = 'g.poore@odey.com;i.murray@odey.com;d.bentley@odey.com'
where ExtractConfigurationId in (6,20)

delete from PortfolioSettlementDate where ReferenceDate = '13-jun-2011'
update PortfolioRollDate set RollDate = '12-jun-2011' where PortfolioAggregationLevelId = 3
	
	select * from PortfolioRollDate
select * from country




INSERT INTO [Keeley].[dbo].[RawPrice]
           ([InstrumentMarketId]
           ,[ReferenceDate]
           ,[EntityRankingSchemeItemId]
           ,[BidValue]
           ,[BidUpdateDate]
           ,[AskValue]
           ,[AskUpdateDate]
           ,[StartDt]
           ,[UpdateUserID]
           ,[RawPriceUsedId])
     VALUES
           (2
           ,'7-may-2011'
           ,1
           ,7
           ,GETDATE()
           ,7
           ,GETDATE()
           ,GETDATE()
           ,1
           ,null)
GO

INSERT INTO [Keeley].[dbo].[EntityRankingSchemeItem]
           ([Name]
           ,[EntityTypeId]
           ,[FMValueSpecId]
           ,[StartDt]
           ,[UpdateUserID])
     VALUES
           ('Manual Price'
           ,18
           ,1
           ,GETDATE()
           ,1)
GO

select * from [EntityRankingSchemeItem]



INSERT INTO [Keeley].[dbo].[Price]
           ([InstrumentMarketId]
           ,[ReferenceDate]
           ,[EntityRankingSchemeId]
           ,[RawPriceId]
           ,[Value]
           ,[StartDt]
           ,[UpdateUserID])
     VALUES
           (2
           ,'7-may-2011'
           ,1
           ,2
           ,1
           ,GETDATE()
           ,1)
GO

select	* 
from	Price p,
		RawPrice r
where	p.RawPriceId = r.RawPriceId		
and		'2-may-2011' between r.ReferenceDate and p.ReferenceDate

alter table RawPrice add  CONSTRAINT RawPriceUserIDFK FOREIGN KEY (updateUSERID) REFERENCES ApplicationUser(UserID)

alter table Price add EntityRankingSchemeItemId int CONSTRAINT PriceEntityRankingSchemeItemIdFK FOREIGN KEY REFERENCES EntityRankingSchemeItem(EntityRankingSchemeItemId)

alter table Price alter column EntityRankingSchemeItemId int not null

update Price set EntityRankingSchemeItemId = 1

drop table Price_hst