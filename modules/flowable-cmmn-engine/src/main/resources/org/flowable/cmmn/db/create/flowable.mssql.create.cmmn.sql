CREATE TABLE ACT_CMMN_DEPLOYMENT (ID_ varchar(255) NOT NULL, NAME_ varchar(255), CATEGORY_ varchar(255), KEY_ varchar(255), DEPLOY_TIME_ datetime, PARENT_DEPLOYMENT_ID_ varchar(255), TENANT_ID_ varchar(255) CONSTRAINT DF_ACT_CMMN_DEPLOYMENT_TENANT_ID_ DEFAULT '', CONSTRAINT PK_ACT_CMMN_DEPLOYMENT PRIMARY KEY (ID_));

CREATE TABLE ACT_CMMN_DEPLOYMENT_RESOURCE (ID_ varchar(255) NOT NULL, NAME_ varchar(255), DEPLOYMENT_ID_ varchar(255), RESOURCE_BYTES_ varbinary(MAX), CONSTRAINT PK_CMMN_DEPLOYMENT_RESOURCE PRIMARY KEY (ID_));

ALTER TABLE ACT_CMMN_DEPLOYMENT_RESOURCE ADD CONSTRAINT ACT_FK_CMMN_RSRC_DPL FOREIGN KEY (DEPLOYMENT_ID_) REFERENCES ACT_CMMN_DEPLOYMENT (ID_);

CREATE NONCLUSTERED INDEX ACT_IDX_CMMN_RSRC_DPL ON ACT_CMMN_DEPLOYMENT_RESOURCE(DEPLOYMENT_ID_);

CREATE TABLE ACT_CMMN_CASEDEF (ID_ varchar(255) NOT NULL, REV_ int NOT NULL, NAME_ varchar(255), KEY_ varchar(255) NOT NULL, VERSION_ int NOT NULL, CATEGORY_ varchar(255), DEPLOYMENT_ID_ varchar(255), RESOURCE_NAME_ varchar(4000), DESCRIPTION_ varchar(4000), HAS_GRAPHICAL_NOTATION_ bit, TENANT_ID_ varchar(255) CONSTRAINT DF_ACT_CMMN_CASEDEF_TENANT_ID_ DEFAULT '', CONSTRAINT PK_ACT_CMMN_CASEDEF PRIMARY KEY (ID_));

ALTER TABLE ACT_CMMN_CASEDEF ADD CONSTRAINT ACT_FK_CASE_DEF_DPLY FOREIGN KEY (DEPLOYMENT_ID_) REFERENCES ACT_CMMN_DEPLOYMENT (ID_);

CREATE NONCLUSTERED INDEX ACT_IDX_CASE_DEF_DPLY ON ACT_CMMN_CASEDEF(DEPLOYMENT_ID_);

CREATE TABLE ACT_CMMN_RU_CASE_INST (ID_ varchar(255) NOT NULL, REV_ int NOT NULL, BUSINESS_KEY_ varchar(255), NAME_ varchar(255), PARENT_ID_ varchar(255), CASE_DEF_ID_ varchar(255), STATE_ varchar(255), START_TIME_ datetime, START_USER_ID_ varchar(255), CALLBACK_ID_ varchar(255), CALLBACK_TYPE_ varchar(255), TENANT_ID_ varchar(255) CONSTRAINT DF_ACT_CMMN_RU_CASE_INST_TENANT_ID_ DEFAULT '', CONSTRAINT PK_ACT_CMMN_RU_CASE_INST PRIMARY KEY (ID_));

ALTER TABLE ACT_CMMN_RU_CASE_INST ADD CONSTRAINT ACT_FK_CASE_INST_CASE_DEF FOREIGN KEY (CASE_DEF_ID_) REFERENCES ACT_CMMN_CASEDEF (ID_);

CREATE NONCLUSTERED INDEX ACT_IDX_CASE_INST_CASE_DEF ON ACT_CMMN_RU_CASE_INST(CASE_DEF_ID_);

CREATE NONCLUSTERED INDEX ACT_IDX_CASE_INST_PARENT ON ACT_CMMN_RU_CASE_INST(PARENT_ID_);

CREATE TABLE ACT_CMMN_RU_PLAN_ITEM_INST (ID_ varchar(255) NOT NULL, REV_ int NOT NULL, CASE_DEF_ID_ varchar(255), CASE_INST_ID_ varchar(255), STAGE_INST_ID_ varchar(255), IS_STAGE_ bit, ELEMENT_ID_ varchar(255), NAME_ varchar(255), STATE_ varchar(255), START_TIME_ datetime, START_USER_ID_ varchar(255), REFERENCE_ID_ varchar(255), REFERENCE_TYPE_ varchar(255), TENANT_ID_ varchar(255) CONSTRAINT DF_ACT_CMMN_RU_PLAN_ITEM_INST_TENANT_ID_ DEFAULT '', CONSTRAINT PK_CMMN_PLAN_ITEM_INST PRIMARY KEY (ID_));

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD CONSTRAINT ACT_FK_PLAN_ITEM_CASE_DEF FOREIGN KEY (CASE_DEF_ID_) REFERENCES ACT_CMMN_CASEDEF (ID_);

CREATE NONCLUSTERED INDEX ACT_IDX_PLAN_ITEM_CASE_DEF ON ACT_CMMN_RU_PLAN_ITEM_INST(CASE_DEF_ID_);

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD CONSTRAINT ACT_FK_PLAN_ITEM_CASE_INST FOREIGN KEY (CASE_INST_ID_) REFERENCES ACT_CMMN_RU_CASE_INST (ID_);

CREATE NONCLUSTERED INDEX ACT_IDX_PLAN_ITEM_CASE_INST ON ACT_CMMN_RU_PLAN_ITEM_INST(CASE_INST_ID_);

CREATE TABLE ACT_CMMN_RU_SENTRY_PART_INST (ID_ varchar(255) NOT NULL, REV_ int NOT NULL, CASE_DEF_ID_ varchar(255), CASE_INST_ID_ varchar(255), PLAN_ITEM_INST_ID_ varchar(255), ON_PART_ID_ varchar(255), IF_PART_ID_ varchar(255), TIME_STAMP_ datetime, CONSTRAINT PK_CMMN_SENTRY_PART_INST PRIMARY KEY (ID_));

ALTER TABLE ACT_CMMN_RU_SENTRY_PART_INST ADD CONSTRAINT ACT_FK_SENTRY_CASE_DEF FOREIGN KEY (CASE_DEF_ID_) REFERENCES ACT_CMMN_CASEDEF (ID_);

CREATE NONCLUSTERED INDEX ACT_IDX_SENTRY_CASE_DEF ON ACT_CMMN_RU_SENTRY_PART_INST(CASE_DEF_ID_);

ALTER TABLE ACT_CMMN_RU_SENTRY_PART_INST ADD CONSTRAINT ACT_FK_SENTRY_CASE_INST FOREIGN KEY (CASE_INST_ID_) REFERENCES ACT_CMMN_RU_CASE_INST (ID_);

CREATE NONCLUSTERED INDEX ACT_IDX_SENTRY_CASE_INST ON ACT_CMMN_RU_SENTRY_PART_INST(CASE_INST_ID_);

ALTER TABLE ACT_CMMN_RU_SENTRY_PART_INST ADD CONSTRAINT ACT_FK_SENTRY_PLAN_ITEM FOREIGN KEY (PLAN_ITEM_INST_ID_) REFERENCES ACT_CMMN_RU_PLAN_ITEM_INST (ID_);

CREATE NONCLUSTERED INDEX ACT_IDX_SENTRY_PLAN_ITEM ON ACT_CMMN_RU_SENTRY_PART_INST(PLAN_ITEM_INST_ID_);

CREATE TABLE ACT_CMMN_RU_MIL_INST (ID_ varchar(255) NOT NULL, NAME_ varchar(255) NOT NULL, TIME_STAMP_ datetime NOT NULL, CASE_INST_ID_ varchar(255) NOT NULL, CASE_DEF_ID_ varchar(255) NOT NULL, ELEMENT_ID_ varchar(255) NOT NULL, CONSTRAINT PK_ACT_CMMN_RU_MIL_INST PRIMARY KEY (ID_));

ALTER TABLE ACT_CMMN_RU_MIL_INST ADD CONSTRAINT ACT_FK_MIL_CASE_DEF FOREIGN KEY (CASE_DEF_ID_) REFERENCES ACT_CMMN_CASEDEF (ID_);

CREATE NONCLUSTERED INDEX ACT_IDX_MIL_CASE_DEF ON ACT_CMMN_RU_MIL_INST(CASE_DEF_ID_);

ALTER TABLE ACT_CMMN_RU_MIL_INST ADD CONSTRAINT ACT_FK_MIL_CASE_INST FOREIGN KEY (CASE_INST_ID_) REFERENCES ACT_CMMN_RU_CASE_INST (ID_);

CREATE NONCLUSTERED INDEX ACT_IDX_MIL_CASE_INST ON ACT_CMMN_RU_MIL_INST(CASE_INST_ID_);

CREATE TABLE ACT_CMMN_HI_CASE_INST (ID_ varchar(255) NOT NULL, REV_ int NOT NULL, BUSINESS_KEY_ varchar(255), NAME_ varchar(255), PARENT_ID_ varchar(255), CASE_DEF_ID_ varchar(255), STATE_ varchar(255), START_TIME_ datetime, END_TIME_ datetime, START_USER_ID_ varchar(255), CALLBACK_ID_ varchar(255), CALLBACK_TYPE_ varchar(255), TENANT_ID_ varchar(255) CONSTRAINT DF_ACT_CMMN_HI_CASE_INST_TENANT_ID_ DEFAULT '', CONSTRAINT PK_ACT_CMMN_HI_CASE_INST PRIMARY KEY (ID_));

CREATE TABLE ACT_CMMN_HI_MIL_INST (ID_ varchar(255) NOT NULL, REV_ int NOT NULL, NAME_ varchar(255) NOT NULL, TIME_STAMP_ datetime NOT NULL, CASE_INST_ID_ varchar(255) NOT NULL, CASE_DEF_ID_ varchar(255) NOT NULL, ELEMENT_ID_ varchar(255) NOT NULL, CONSTRAINT PK_ACT_CMMN_HI_MIL_INST PRIMARY KEY (ID_));

ALTER TABLE ACT_CMMN_CASEDEF ADD DGRM_RESOURCE_NAME_ varchar(4000);

ALTER TABLE ACT_CMMN_CASEDEF ADD HAS_START_FORM_KEY_ bit;

ALTER TABLE ACT_CMMN_DEPLOYMENT_RESOURCE ADD GENERATED_ bit;

ALTER TABLE ACT_CMMN_RU_CASE_INST ADD LOCK_TIME_ datetime;

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD ITEM_DEFINITION_ID_ varchar(255);

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD ITEM_DEFINITION_TYPE_ varchar(255);

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD IS_COMPLETEABLE_ bit;

ALTER TABLE ACT_CMMN_RU_CASE_INST ADD IS_COMPLETEABLE_ bit;

CREATE NONCLUSTERED INDEX ACT_IDX_PLAN_ITEM_STAGE_INST ON ACT_CMMN_RU_PLAN_ITEM_INST(STAGE_INST_ID_);

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD IS_COUNT_ENABLED_ bit;

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD VAR_COUNT_ int;

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD SENTRY_PART_INST_COUNT_ int;

CREATE TABLE ACT_CMMN_HI_PLAN_ITEM_INST (ID_ varchar(255) NOT NULL, REV_ int NOT NULL, NAME_ varchar(255), STATE_ varchar(255), CASE_DEF_ID_ varchar(255), CASE_INST_ID_ varchar(255), STAGE_INST_ID_ varchar(255), IS_STAGE_ bit, ELEMENT_ID_ varchar(255), ITEM_DEFINITION_ID_ varchar(255), ITEM_DEFINITION_TYPE_ varchar(255), CREATED_TIME_ datetime, LAST_AVAILABLE_TIME_ datetime, LAST_ENABLED_TIME_ datetime, LAST_DISABLED_TIME_ datetime, LAST_STARTED_TIME_ datetime, LAST_SUSPENDED_TIME_ datetime, COMPLETED_TIME_ datetime, OCCURRED_TIME_ datetime, TERMINATED_TIME_ datetime, EXIT_TIME_ datetime, ENDED_TIME_ datetime, LAST_UPDATED_TIME_ datetime, START_USER_ID_ varchar(255), REFERENCE_ID_ varchar(255), REFERENCE_TYPE_ varchar(255), TENANT_ID_ varchar(255) CONSTRAINT DF_ACT_CMMN_HI_PLAN_ITEM_INST_TENANT_ID_ DEFAULT '', CONSTRAINT PK_ACT_CMMN_HI_PLAN_ITEM_INST PRIMARY KEY (ID_));

ALTER TABLE ACT_CMMN_RU_MIL_INST ADD TENANT_ID_ varchar(255) CONSTRAINT DF_ACT_CMMN_RU_MIL_INST_TENANT_ID_ DEFAULT '';

ALTER TABLE ACT_CMMN_HI_MIL_INST ADD TENANT_ID_ varchar(255) CONSTRAINT DF_ACT_CMMN_HI_MIL_INST_TENANT_ID_ DEFAULT '';

CREATE UNIQUE NONCLUSTERED INDEX ACT_IDX_CASE_DEF_UNIQ ON ACT_CMMN_CASEDEF(KEY_, VERSION_, TENANT_ID_);

exec sp_rename 'ACT_CMMN_RU_PLAN_ITEM_INST.START_TIME_', 'CREATE_TIME_', 'COLUMN';

exec sp_rename 'ACT_CMMN_HI_PLAN_ITEM_INST.CREATED_TIME_', 'CREATE_TIME_', 'COLUMN';

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD LAST_AVAILABLE_TIME_ datetime;

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD LAST_ENABLED_TIME_ datetime;

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD LAST_DISABLED_TIME_ datetime;

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD LAST_STARTED_TIME_ datetime;

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD LAST_SUSPENDED_TIME_ datetime;

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD COMPLETED_TIME_ datetime;

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD OCCURRED_TIME_ datetime;

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD TERMINATED_TIME_ datetime;

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD EXIT_TIME_ datetime;

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD ENDED_TIME_ datetime;

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD ENTRY_CRITERION_ID_ varchar(255);

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD EXIT_CRITERION_ID_ varchar(255);

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST ADD ENTRY_CRITERION_ID_ varchar(255);

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST ADD EXIT_CRITERION_ID_ varchar(255);

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST ADD SHOW_IN_OVERVIEW_ bit;

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD EXTRA_VALUE_ varchar(255);

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST ADD EXTRA_VALUE_ varchar(255);

ALTER TABLE ACT_CMMN_RU_CASE_INST ADD REFERENCE_ID_ varchar(255);

ALTER TABLE ACT_CMMN_RU_CASE_INST ADD REFERENCE_TYPE_ varchar(255);

CREATE NONCLUSTERED INDEX ACT_IDX_CASE_INST_REF_ID_ ON ACT_CMMN_RU_CASE_INST(REFERENCE_ID_);

ALTER TABLE ACT_CMMN_HI_CASE_INST ADD REFERENCE_ID_ varchar(255);

ALTER TABLE ACT_CMMN_HI_CASE_INST ADD REFERENCE_TYPE_ varchar(255);

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD DERIVED_CASE_DEF_ID_ varchar(255);

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST ADD DERIVED_CASE_DEF_ID_ varchar(255);

ALTER TABLE ACT_CMMN_RU_CASE_INST ADD LOCK_OWNER_ varchar(255);

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ADD LAST_UNAVAILABLE_TIME_ datetime;

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST ADD LAST_UNAVAILABLE_TIME_ datetime;

ALTER TABLE ACT_CMMN_RU_CASE_INST ADD LAST_REACTIVATION_TIME_ datetime;

ALTER TABLE ACT_CMMN_RU_CASE_INST ADD LAST_REACTIVATION_USER_ID_ varchar(255);

ALTER TABLE ACT_CMMN_HI_CASE_INST ADD LAST_REACTIVATION_TIME_ datetime;

ALTER TABLE ACT_CMMN_HI_CASE_INST ADD LAST_REACTIVATION_USER_ID_ varchar(255);

ALTER TABLE ACT_CMMN_RU_CASE_INST ADD BUSINESS_STATUS_ varchar(255);

ALTER TABLE ACT_CMMN_HI_CASE_INST ADD BUSINESS_STATUS_ varchar(255);

CREATE NONCLUSTERED INDEX ACT_IDX_HI_CASE_INST_END ON ACT_CMMN_HI_CASE_INST(END_TIME_);

CREATE NONCLUSTERED INDEX ACT_IDX_HI_PLAN_ITEM_INST_CASE ON ACT_CMMN_HI_PLAN_ITEM_INST(CASE_INST_ID_);

ALTER TABLE ACT_CMMN_DEPLOYMENT ALTER COLUMN NAME_ nvarchar(255);

ALTER TABLE ACT_CMMN_DEPLOYMENT_RESOURCE ALTER COLUMN NAME_ nvarchar(255);

ALTER TABLE ACT_CMMN_CASEDEF ALTER COLUMN NAME_ nvarchar(255);

ALTER TABLE ACT_CMMN_CASEDEF ALTER COLUMN RESOURCE_NAME_ nvarchar(255);

ALTER TABLE ACT_CMMN_CASEDEF ALTER COLUMN DGRM_RESOURCE_NAME_ nvarchar(255);

ALTER TABLE ACT_CMMN_RU_CASE_INST ALTER COLUMN NAME_ nvarchar(255);

ALTER TABLE ACT_CMMN_RU_CASE_INST ALTER COLUMN BUSINESS_KEY_ nvarchar(255);

ALTER TABLE ACT_CMMN_RU_CASE_INST ALTER COLUMN BUSINESS_STATUS_ nvarchar(255);

ALTER TABLE ACT_CMMN_RU_MIL_INST ALTER COLUMN NAME_ nvarchar(255);

ALTER TABLE ACT_CMMN_RU_PLAN_ITEM_INST ALTER COLUMN NAME_ nvarchar(255);

ALTER TABLE ACT_CMMN_HI_MIL_INST ALTER COLUMN NAME_ nvarchar(255);

ALTER TABLE ACT_CMMN_HI_PLAN_ITEM_INST ALTER COLUMN NAME_ nvarchar(255);

ALTER TABLE ACT_CMMN_HI_CASE_INST ALTER COLUMN NAME_ nvarchar(255);

ALTER TABLE ACT_CMMN_HI_CASE_INST ALTER COLUMN BUSINESS_KEY_ nvarchar(255);

ALTER TABLE ACT_CMMN_HI_CASE_INST ALTER COLUMN BUSINESS_STATUS_ nvarchar(255);

ALTER TABLE ACT_CMMN_CASEDEF ALTER COLUMN DESCRIPTION_ nvarchar(4000);

insert into ACT_GE_PROPERTY
values ('cmmn.schema.version', '7.1.0.1', 1);