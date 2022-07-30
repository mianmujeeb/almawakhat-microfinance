BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"action_time"	datetime NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Currencies" (
	"id"	integer NOT NULL,
	"status"	integer NOT NULL,
	"name"	varchar(30) NOT NULL,
	"code"	varchar(5) NOT NULL,
	"symbol"	varchar(20) NOT NULL,
	"position"	integer NOT NULL,
	"fractional_units"	varchar(20) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Regions" (
	"id"	integer NOT NULL,
	"status"	integer NOT NULL,
	"name"	varchar(50) NOT NULL,
	"code_digit"	varchar(10) NOT NULL,
	"code_alpha"	varchar(10) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "States" (
	"id"	integer NOT NULL,
	"status"	integer NOT NULL,
	"name"	varchar(50) NOT NULL,
	"latitude"	varchar(20) NOT NULL,
	"longitude"	varchar(20) NOT NULL,
	"code_digit"	varchar(5) NOT NULL,
	"code_alpha"	varchar(5) NOT NULL,
	"country_id"	bigint NOT NULL,
	FOREIGN KEY("country_id") REFERENCES "Countries"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Sub States" (
	"id"	integer NOT NULL,
	"status"	integer NOT NULL,
	"name"	varchar(50) NOT NULL,
	"latitude"	varchar(20) NOT NULL,
	"longitude"	varchar(20) NOT NULL,
	"country_id"	bigint NOT NULL,
	"state_id"	bigint NOT NULL,
	FOREIGN KEY("state_id") REFERENCES "States"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("country_id") REFERENCES "Countries"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Countries" (
	"id"	integer NOT NULL,
	"status"	integer NOT NULL,
	"name"	varchar(50) NOT NULL,
	"iso2digit"	varchar(2) NOT NULL,
	"iso3digit"	varchar(3) NOT NULL,
	"calling_code"	varchar(10) NOT NULL,
	"latitude"	varchar(20) NOT NULL,
	"longitude"	varchar(20) NOT NULL,
	"timezone"	varchar(50) NOT NULL,
	"currency_id"	bigint NOT NULL,
	"region_id"	bigint NOT NULL,
	FOREIGN KEY("region_id") REFERENCES "Regions"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("currency_id") REFERENCES "Currencies"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "settings_city" (
	"id"	integer NOT NULL,
	"status"	integer NOT NULL,
	"name"	varchar(50) NOT NULL,
	"latitude"	varchar(20) NOT NULL,
	"longitude"	varchar(20) NOT NULL,
	"code_digit"	varchar(5) NOT NULL,
	"code_alpha"	varchar(5) NOT NULL,
	"country_id"	bigint NOT NULL,
	"state_id"	bigint NOT NULL,
	"sub_state_id"	bigint NOT NULL,
	FOREIGN KEY("state_id") REFERENCES "States"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("sub_state_id") REFERENCES "Sub States"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("country_id") REFERENCES "Countries"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Applicant Bank Accounts" (
	"id"	integer NOT NULL,
	"name"	varchar(100) NOT NULL,
	"branch"	varchar(200) NOT NULL,
	"account_type"	integer NOT NULL,
	"account_title"	varchar(100) NOT NULL,
	"account_number"	varchar(150) NOT NULL,
	"account_opening_date"	date NOT NULL,
	"applicant_id"	bigint NOT NULL,
	FOREIGN KEY("applicant_id") REFERENCES "Applicants"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"last_name"	varchar(150) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"first_name"	varchar(150) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Product Categories" (
	"id"	integer NOT NULL,
	"status"	integer NOT NULL,
	"name"	varchar(100) NOT NULL,
	"description"	varchar(300),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
CREATE TABLE IF NOT EXISTS "Applicant Guarantors" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL,
	"relation"	varchar(50) NOT NULL,
	"cnic"	varchar(20) NOT NULL,
	"whatsapp"	varchar(20) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"address"	varchar(250) NOT NULL,
	"years_know"	integer NOT NULL,
	"photo"	varchar(100) NOT NULL,
	"applicant_id"	bigint NOT NULL,
	"city_id"	bigint NOT NULL,
	"phone"	varchar(20) NOT NULL,
	"cnic_photo_back"	varchar(100) NOT NULL,
	"cnic_photo_front"	varchar(100) NOT NULL,
	FOREIGN KEY("applicant_id") REFERENCES "Applicants"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("city_id") REFERENCES "settings_city"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Applicants" (
	"id"	integer NOT NULL,
	"status"	integer NOT NULL,
	"refrence_number"	varchar(100) NOT NULL,
	"salutation"	integer NOT NULL,
	"name"	varchar(120) NOT NULL,
	"father_husband_name"	varchar(120) NOT NULL,
	"mother_name"	varchar(120) NOT NULL,
	"cnic"	varchar(20) NOT NULL,
	"dob"	date NOT NULL,
	"gender"	integer NOT NULL,
	"marital_status"	integer NOT NULL,
	"phone"	varchar(20) NOT NULL,
	"whatsapp"	varchar(30) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"education"	varchar(150) NOT NULL,
	"education_institute"	varchar(120) NOT NULL,
	"job_status"	integer NOT NULL,
	"residence_status"	integer NOT NULL,
	"monthly_rent"	decimal,
	"mailing_address"	varchar(255) NOT NULL,
	"residing_duration"	integer NOT NULL,
	"current_address"	varchar(255) NOT NULL,
	"profession"	varchar(100) NOT NULL,
	"organization"	varchar(150) NOT NULL,
	"organization_type"	integer NOT NULL,
	"doj"	date NOT NULL,
	"experience"	integer NOT NULL,
	"monthly_income"	decimal NOT NULL,
	"office_phone"	varchar(20) NOT NULL,
	"office_email"	varchar(254) NOT NULL,
	"office_address"	varchar(255) NOT NULL,
	"previous_loan"	decimal NOT NULL,
	"previous_loan_deduction"	decimal NOT NULL,
	"monthly_expense"	decimal NOT NULL,
	"remarks"	text,
	"photo"	varchar(100) NOT NULL,
	"date_added"	datetime NOT NULL,
	"date_updated"	datetime NOT NULL,
	"added_by_id"	integer NOT NULL,
	"updated_by_id"	integer,
	"monthly_other_income"	decimal NOT NULL,
	"education_verification"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("updated_by_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("added_by_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "Products" (
	"id"	integer NOT NULL,
	"status"	integer NOT NULL,
	"code"	varchar(20) NOT NULL,
	"name"	varchar(100) NOT NULL,
	"brand"	varchar(150) NOT NULL,
	"model"	varchar(150) NOT NULL,
	"price"	real NOT NULL,
	"description"	text,
	"date_added"	datetime NOT NULL,
	"date_updated"	datetime,
	"added_by_id"	integer NOT NULL,
	"updated_by_id"	integer,
	"category_id"	bigint NOT NULL,
	"picture"	varchar(100),
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("updated_by_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("category_id") REFERENCES "Product Categories"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("added_by_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "Financing Modes" (
	"id"	integer NOT NULL,
	"status"	integer NOT NULL,
	"name"	varchar(100) NOT NULL,
	"description"	text,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "finance_applicantproduct" (
	"id"	integer NOT NULL,
	"financing_amount"	decimal NOT NULL,
	"security_amount"	decimal NOT NULL,
	"tenure"	integer NOT NULL,
	"rent"	integer NOT NULL,
	"installment_start_date"	date NOT NULL,
	"emi"	integer NOT NULL,
	"date_added"	datetime NOT NULL,
	"date_updated"	datetime NOT NULL,
	"added_by_id"	integer NOT NULL,
	"applicant_id"	bigint NOT NULL,
	"financing_mode_id"	bigint NOT NULL,
	"product_id"	bigint NOT NULL,
	"updated_by_id"	integer,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("added_by_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("financing_mode_id") REFERENCES "Financing Modes"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("product_id") REFERENCES "Products"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("applicant_id") REFERENCES "Applicants"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("updated_by_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "finance_emichallanparticular" (
	"id"	integer NOT NULL,
	"status"	integer NOT NULL,
	"name"	varchar(100) NOT NULL,
	"description"	text,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "finance_applicantproductchallandetail" (
	"id"	integer NOT NULL,
	"challan_id"	bigint NOT NULL,
	"amount"	integer NOT NULL,
	"particular_id"	bigint NOT NULL,
	FOREIGN KEY("particular_id") REFERENCES "finance_emichallanparticular"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("challan_id") REFERENCES "finance_applicantproductchallan"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "finance_emichallanprofile" (
	"id"	integer NOT NULL,
	"title"	varchar(100) NOT NULL,
	"logo"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "finance_emichallanbankaccount" (
	"id"	integer NOT NULL,
	"name"	varchar(100) NOT NULL,
	"account_number"	varchar(100) NOT NULL,
	"status"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "finance_applicantproductchallan" (
	"id"	integer NOT NULL,
	"status"	integer NOT NULL,
	"challan_number"	varchar(999) NOT NULL,
	"issue_date"	date NOT NULL,
	"due_date"	date NOT NULL,
	"applicant_id"	bigint NOT NULL,
	"product_id"	bigint NOT NULL,
	"payable_after_due_date"	integer,
	"payable_till_due_date"	integer,
	"reference_numebr"	varchar(999) NOT NULL,
	"voucher_numebr"	varchar(999) NOT NULL,
	"principal_outstanding_amount"	integer,
	FOREIGN KEY("applicant_id") REFERENCES "Applicants"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("product_id") REFERENCES "finance_applicantproduct"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (1,'contenttypes','0001_initial','2022-06-21 06:53:46.593775'),
 (2,'auth','0001_initial','2022-06-21 06:53:46.624608'),
 (3,'admin','0001_initial','2022-06-21 06:53:46.643983'),
 (4,'admin','0002_logentry_remove_auto_add','2022-06-21 06:53:46.675989'),
 (5,'admin','0003_logentry_add_action_flag_choices','2022-06-21 06:53:46.695703'),
 (6,'settings','0001_initial','2022-06-21 06:53:46.758500'),
 (7,'applicants','0001_initial','2022-06-21 06:53:46.816500'),
 (8,'contenttypes','0002_remove_content_type_name','2022-06-21 06:53:46.874668'),
 (9,'auth','0002_alter_permission_name_max_length','2022-06-21 06:53:46.935292'),
 (10,'auth','0003_alter_user_email_max_length','2022-06-21 06:53:46.959269'),
 (11,'auth','0004_alter_user_username_opts','2022-06-21 06:53:46.979422'),
 (12,'auth','0005_alter_user_last_login_null','2022-06-21 06:53:47.016596'),
 (13,'auth','0006_require_contenttypes_0002','2022-06-21 06:53:47.024060'),
 (14,'auth','0007_alter_validators_add_error_messages','2022-06-21 06:53:47.041600'),
 (15,'auth','0008_alter_user_username_max_length','2022-06-21 06:53:47.068781'),
 (16,'auth','0009_alter_user_last_name_max_length','2022-06-21 06:53:47.088665'),
 (17,'auth','0010_alter_group_name_max_length','2022-06-21 06:53:47.114359'),
 (18,'auth','0011_update_proxy_permissions','2022-06-21 06:53:47.141077'),
 (19,'auth','0012_alter_user_first_name_max_length','2022-06-21 06:53:47.166457'),
 (20,'inventory','0001_initial','2022-06-21 06:53:47.199758'),
 (21,'sessions','0001_initial','2022-06-21 06:53:47.213018'),
 (22,'applicants','0002_delete_modelname_and_more','2022-06-21 07:09:49.984773'),
 (23,'inventory','0002_rename_catgory_product_category','2022-06-21 07:09:50.020493'),
 (24,'applicants','0003_rename_monthly_otherincome_applicant_monthly_other_income_and_more','2022-06-27 10:16:55.674653'),
 (25,'applicants','0004_rename_cnic_photo_applicantguarantor_cnic_photo_back_and_more','2022-06-27 10:49:31.447884'),
 (26,'applicants','0005_alter_applicant_residing_duration','2022-06-28 07:13:45.705596'),
 (27,'applicants','0006_alter_applicant_education_verification','2022-07-04 12:10:50.208269'),
 (28,'applicants','0007_alter_applicantguarantor_city_applicantproduct','2022-07-18 09:15:41.082339'),
 (29,'applicants','0008_applicantproduct_added_by_and_more','2022-07-18 09:21:22.058642'),
 (30,'applicants','0009_applicantproduct_installment_start_date','2022-07-18 09:34:00.293524'),
 (31,'applicants','0010_alter_applicantproduct_installment_start_date','2022-07-18 11:29:18.315302'),
 (32,'applicants','0011_applicantproduct_emi','2022-07-20 06:55:03.460998'),
 (33,'applicants','0012_rename_emi_applicantproduct_emi','2022-07-20 06:57:14.765733'),
 (34,'inventory','0003_product_picture','2022-07-20 09:20:04.815585'),
 (35,'applicants','0013_delete_applicantproduct','2022-07-21 11:29:46.179205'),
 (36,'finance','0001_initial','2022-07-21 11:29:46.331204'),
 (37,'finance','0002_emichallanparticular','2022-07-22 07:21:38.021255'),
 (38,'finance','0003_applicantproductchallan_payable_after_due_date_and_more','2022-07-22 12:00:14.651154'),
 (39,'finance','0004_emichallanbankaccount_emichallanprofile','2022-07-22 12:15:58.551268'),
 (40,'finance','0005_emichallanbankaccount_status','2022-07-22 12:22:52.108577'),
 (41,'finance','0006_alter_applicantproductchallan_status','2022-07-22 13:50:35.429430'),
 (42,'finance','0007_alter_applicantproductchallan_options_and_more','2022-07-24 19:29:26.324799'),
 (43,'finance','0008_alter_applicantproductchallan_applicant_and_more','2022-07-24 19:31:15.578278'),
 (44,'finance','0009_alter_applicantproductchallan_applicant','2022-07-25 08:00:41.259768'),
 (45,'finance','0010_alter_applicantproductchallan_payable_after_due_date_and_more','2022-07-25 10:18:33.736104');
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (1,'2022-06-21 07:16:13.227252','1','Americas','[{"added": {}}]',9,1,1),
 (2,'2022-06-21 07:16:27.373726','2','Asia Pacific','[{"added": {}}]',9,1,1),
 (3,'2022-06-21 07:16:38.378167','3','Europe','[{"added": {}}]',9,1,1),
 (4,'2022-06-21 07:16:59.832893','4','Middle East/Africa','[{"added": {}}]',9,1,1),
 (5,'2022-06-21 07:30:41.692954','1','Pakistani Rupees','[{"added": {}}]',8,1,1),
 (6,'2022-06-21 07:30:43.397953','1','Pakistan','[{"added": {}}]',7,1,1),
 (7,'2022-06-21 07:31:52.169310','1','Punjab','[{"added": {}}]',10,1,1),
 (8,'2022-06-21 07:32:34.892403','1','Faisalabad','[{"added": {}}]',11,1,1),
 (9,'2022-06-21 07:33:14.284267','1','Jhang','[{"added": {}}]',12,1,1),
 (10,'2022-06-30 06:50:38.232002','1','admin','[{"changed": {"fields": ["First name", "Last name"]}}]',4,1,2),
 (11,'2022-07-04 12:14:38.024107','2','Mian Mujeeb','[{"changed": {"fields": ["Name", "Father husband name", "Mother name", "Cnic", "Whatsapp", "Education", "Education institute", "Education verification", "Monthly rent", "Mailing address", "Residing duration", "Current address", "Profession", "Organization", "Organization type", "Experience", "Monthly income", "Office address", "Previous loan", "Previous loan deduction", "Monthly other income", "Monthly expense", "Remarks", "Updated by"]}}]',13,1,2),
 (12,'2022-07-04 12:14:43.052969','1','B8rt5hWgZv','',13,1,3),
 (13,'2022-07-04 12:25:19.120629','2','Mian Mujeeb','[{"changed": {"fields": ["Photo"]}}]',13,1,2),
 (14,'2022-07-04 13:07:19.485227','2','Mian Mujeeb','[{"changed": {"name": "Applicant Bank Account", "object": "Mian Mujeeb", "fields": ["Name", "Branch", "Account title", "Account number"]}}, {"changed": {"name": "Applicant Guarantor", "object": "Ibrar Hussain", "fields": ["Name", "Relation", "Cnic", "Whatsapp", "Email", "Address", "Years know"]}}]',13,1,2),
 (15,'2022-07-14 11:10:36.185746','2','Mian Mujeeb','[{"changed": {"fields": ["Photo"]}}]',13,1,2),
 (16,'2022-07-18 11:29:42.758616','2','Mian Mujeeb','[{"added": {"name": "Applicant Product", "object": "Honda CD 70 updated (Mian Mujeeb)"}}]',13,1,2),
 (17,'2022-07-18 11:33:55.646355','2','Mian Mujeeb','[{"deleted": {"name": "Applicant Product", "object": "Honda CD 70 updated (Mian Mujeeb)"}}]',13,1,2),
 (18,'2022-07-18 12:30:32.297614','2','Mian Mujeeb','[{"deleted": {"name": "Applicant Product", "object": "Honda CD 70 updated (Mian Mujeeb)"}}]',13,1,2),
 (19,'2022-07-18 12:38:01.664571','2','Mian Mujeeb','',13,1,3),
 (20,'2022-07-18 12:45:19.069583','3','Mian Mujeeb','[{"added": {}}]',13,1,1),
 (21,'2022-07-20 06:59:42.851180','3','Mian Mujeeb','[{"deleted": {"name": "Applicant Product", "object": "Honda CD 70 updated (Mian Mujeeb)"}}]',13,1,2),
 (22,'2022-07-20 07:08:26.032376','3','Mian Mujeeb','[{"deleted": {"name": "Applicant Product", "object": "Honda CD 70 updated (Mian Mujeeb)"}}]',13,1,2),
 (23,'2022-07-20 07:13:58.036317','3','Mian Mujeeb','[{"deleted": {"name": "Applicant Product", "object": "Honda CD 70 updated (Mian Mujeeb)"}}]',13,1,2),
 (24,'2022-07-21 11:32:29.978753','1','Dummy','[{"added": {}}]',22,1,1),
 (25,'2022-07-22 12:37:06.142477','1','Al-Mawakhat Microfinance','[{"added": {}}]',26,1,1),
 (26,'2022-07-26 07:02:46.904291','8','123456-HONDA-70-20220726120055','',20,1,3),
 (27,'2022-07-26 07:02:46.911777','7','123456-HONDA-70-20220726120030','',20,1,3),
 (28,'2022-07-26 07:02:46.915961','6','123456-HONDA-70-20220726115958','',20,1,3),
 (29,'2022-07-26 07:02:46.920123','5','123456-HONDA-70-20220726115933','',20,1,3),
 (30,'2022-07-26 07:02:46.924129','4','123456-HONDA-70-20220726115850','',20,1,3),
 (31,'2022-07-26 07:21:44.002427','9','123456-HONDA-70-20220726120213','[{"changed": {"fields": ["Payable till due date"]}}]',20,1,2),
 (32,'2022-07-26 07:22:05.242799','9','123456-HONDA-70-20220726120213','[{"changed": {"fields": ["Payable till due date"]}}]',20,1,2);
INSERT INTO "Currencies" ("id","status","name","code","symbol","position","fractional_units") VALUES (1,1,'Pakistani Rupees','PKR','Rs',1,'2');
INSERT INTO "Regions" ("id","status","name","code_digit","code_alpha") VALUES (1,1,'Americas','123','USA'),
 (2,1,'Asia Pacific','234','ASI'),
 (3,1,'Europe','456','EUR'),
 (4,2,'Middle East/Africa Updated','567 updated','MEA updated');
INSERT INTO "States" ("id","status","name","latitude","longitude","code_digit","code_alpha","country_id") VALUES (1,1,'Punjab','30.86017','30.86017 72.31976','786','PUNJ',1),
 (2,1,'EEEE','dsgf','dfgfd','fdgfd','fgf',1);
INSERT INTO "Sub States" ("id","status","name","latitude","longitude","country_id","state_id") VALUES (1,1,'Faisalabad','31.418715','73.079109',1,1);
INSERT INTO "Countries" ("id","status","name","iso2digit","iso3digit","calling_code","latitude","longitude","timezone","currency_id","region_id") VALUES (1,1,'Pakistan','PK','PAK','+92','30.3753','69.3451','UTC +5',1,2);
INSERT INTO "settings_city" ("id","status","name","latitude","longitude","code_digit","code_alpha","country_id","state_id","sub_state_id") VALUES (1,1,'Dummy','31.278046','72.311760','654','JHANG',1,1,1);
INSERT INTO "Applicant Bank Accounts" ("id","name","branch","account_type","account_title","account_number","account_opening_date","applicant_id") VALUES (2,'Habib Bank Limited','Pindi Stop, Lahore',1,'Muhammad Mujeeb Sattar','21376537','2022-07-19',3),
 (3,'Meezan Bank','Haider Road Lahore',1,'Muhammad Mujeeb Sattar','1327465145676','2022-07-19',3);
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (1,'admin','logentry'),
 (2,'auth','permission'),
 (3,'auth','group'),
 (4,'auth','user'),
 (5,'contenttypes','contenttype'),
 (6,'sessions','session'),
 (7,'settings','country'),
 (8,'settings','currency'),
 (9,'settings','region'),
 (10,'settings','state'),
 (11,'settings','substate'),
 (12,'settings','city'),
 (13,'applicants','applicant'),
 (14,'applicants','modelname'),
 (15,'applicants','applicantguarantor'),
 (16,'applicants','applicantbankaccount'),
 (17,'inventory','productcategory'),
 (18,'inventory','product'),
 (19,'applicants','applicantproduct'),
 (20,'finance','applicantproductchallan'),
 (21,'finance','applicantproduct'),
 (22,'finance','financingmode'),
 (23,'finance','applicantproductchallandetail'),
 (24,'finance','emichallanparticular'),
 (25,'finance','emichallanbankaccount'),
 (26,'finance','emichallanprofile');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (1,1,'add_logentry','Can add log entry'),
 (2,1,'change_logentry','Can change log entry'),
 (3,1,'delete_logentry','Can delete log entry'),
 (4,1,'view_logentry','Can view log entry'),
 (5,2,'add_permission','Can add permission'),
 (6,2,'change_permission','Can change permission'),
 (7,2,'delete_permission','Can delete permission'),
 (8,2,'view_permission','Can view permission'),
 (9,3,'add_group','Can add group'),
 (10,3,'change_group','Can change group'),
 (11,3,'delete_group','Can delete group'),
 (12,3,'view_group','Can view group'),
 (13,4,'add_user','Can add user'),
 (14,4,'change_user','Can change user'),
 (15,4,'delete_user','Can delete user'),
 (16,4,'view_user','Can view user'),
 (17,5,'add_contenttype','Can add content type'),
 (18,5,'change_contenttype','Can change content type'),
 (19,5,'delete_contenttype','Can delete content type'),
 (20,5,'view_contenttype','Can view content type'),
 (21,6,'add_session','Can add session'),
 (22,6,'change_session','Can change session'),
 (23,6,'delete_session','Can delete session'),
 (24,6,'view_session','Can view session'),
 (25,7,'add_country','Can add Country'),
 (26,7,'change_country','Can change Country'),
 (27,7,'delete_country','Can delete Country'),
 (28,7,'view_country','Can view Country'),
 (29,8,'add_currency','Can add Currency'),
 (30,8,'change_currency','Can change Currency'),
 (31,8,'delete_currency','Can delete Currency'),
 (32,8,'view_currency','Can view Currency'),
 (33,9,'add_region','Can add Region'),
 (34,9,'change_region','Can change Region'),
 (35,9,'delete_region','Can delete Region'),
 (36,9,'view_region','Can view Region'),
 (37,10,'add_state','Can add State'),
 (38,10,'change_state','Can change State'),
 (39,10,'delete_state','Can delete State'),
 (40,10,'view_state','Can view State'),
 (41,11,'add_substate','Can add Sub State'),
 (42,11,'change_substate','Can change Sub State'),
 (43,11,'delete_substate','Can delete Sub State'),
 (44,11,'view_substate','Can view Sub State'),
 (45,12,'add_city','Can add City'),
 (46,12,'change_city','Can change City'),
 (47,12,'delete_city','Can delete City'),
 (48,12,'view_city','Can view City'),
 (49,13,'add_applicant','Can add Applicant'),
 (50,13,'change_applicant','Can change Applicant'),
 (51,13,'delete_applicant','Can delete Applicant'),
 (52,13,'view_applicant','Can view Applicant'),
 (53,14,'add_modelname','Can add MODELNAME'),
 (54,14,'change_modelname','Can change MODELNAME'),
 (55,14,'delete_modelname','Can delete MODELNAME'),
 (56,14,'view_modelname','Can view MODELNAME'),
 (57,15,'add_applicantguarantor','Can add Applicant Guarantor'),
 (58,15,'change_applicantguarantor','Can change Applicant Guarantor'),
 (59,15,'delete_applicantguarantor','Can delete Applicant Guarantor'),
 (60,15,'view_applicantguarantor','Can view Applicant Guarantor'),
 (61,16,'add_applicantbankaccount','Can add Applicant Bank Account'),
 (62,16,'change_applicantbankaccount','Can change Applicant Bank Account'),
 (63,16,'delete_applicantbankaccount','Can delete Applicant Bank Account'),
 (64,16,'view_applicantbankaccount','Can view Applicant Bank Account'),
 (65,17,'add_productcategory','Can add Product Category'),
 (66,17,'change_productcategory','Can change Product Category'),
 (67,17,'delete_productcategory','Can delete Product Category'),
 (68,17,'view_productcategory','Can view Product Category'),
 (69,18,'add_product','Can add Product'),
 (70,18,'change_product','Can change Product'),
 (71,18,'delete_product','Can delete Product'),
 (72,18,'view_product','Can view Product'),
 (73,19,'add_applicantproduct','Can add Applicant Product'),
 (74,19,'change_applicantproduct','Can change Applicant Product'),
 (75,19,'delete_applicantproduct','Can delete Applicant Product'),
 (76,19,'view_applicantproduct','Can view Applicant Product'),
 (77,20,'add_applicantproductchallan','Can add Applicant Produt Challan'),
 (78,20,'change_applicantproductchallan','Can change Applicant Produt Challan'),
 (79,20,'delete_applicantproductchallan','Can delete Applicant Produt Challan'),
 (80,20,'view_applicantproductchallan','Can view Applicant Produt Challan'),
 (81,21,'add_applicantproduct','Can add Applicant Product'),
 (82,21,'change_applicantproduct','Can change Applicant Product'),
 (83,21,'delete_applicantproduct','Can delete Applicant Product'),
 (84,21,'view_applicantproduct','Can view Applicant Product'),
 (85,22,'add_financingmode','Can add Financing Mode'),
 (86,22,'change_financingmode','Can change Financing Mode'),
 (87,22,'delete_financingmode','Can delete Financing Mode'),
 (88,22,'view_financingmode','Can view Financing Mode'),
 (89,23,'add_applicantproductchallandetail','Can add Applicant Product Challan Detail'),
 (90,23,'change_applicantproductchallandetail','Can change Applicant Product Challan Detail'),
 (91,23,'delete_applicantproductchallandetail','Can delete Applicant Product Challan Detail'),
 (92,23,'view_applicantproductchallandetail','Can view Applicant Product Challan Detail'),
 (93,24,'add_emichallanparticular','Can add EMI Challan Particular'),
 (94,24,'change_emichallanparticular','Can change EMI Challan Particular'),
 (95,24,'delete_emichallanparticular','Can delete EMI Challan Particular'),
 (96,24,'view_emichallanparticular','Can view EMI Challan Particular'),
 (97,25,'add_emichallanbankaccount','Can add EMI Challan Bank Account'),
 (98,25,'change_emichallanbankaccount','Can change EMI Challan Bank Account'),
 (99,25,'delete_emichallanbankaccount','Can delete EMI Challan Bank Account'),
 (100,25,'view_emichallanbankaccount','Can view EMI Challan Bank Account'),
 (101,26,'add_emichallanprofile','Can add EMI Challan Profile'),
 (102,26,'change_emichallanprofile','Can change EMI Challan Profile'),
 (103,26,'delete_emichallanprofile','Can delete EMI Challan Profile'),
 (104,26,'view_emichallanprofile','Can view EMI Challan Profile');
INSERT INTO "auth_user" ("id","password","last_login","is_superuser","username","last_name","email","is_staff","is_active","date_joined","first_name") VALUES (1,'pbkdf2_sha256$320000$18vfDDhekwH8Sj4W1cSUk3$3LvjeJ58V3isSNW5C7q6/7suM9oiREiaUMHoaiiGr9o=','2022-07-27 06:07:49.359163',1,'admin','Admin','admin@mail.com',1,1,'2022-06-21 06:54:16','Super');
INSERT INTO "Product Categories" ("id","status","name","description") VALUES (1,2,'Automobiles','All transport items updated');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('t177jj1ze10zbx8ez6obl0b8sctlvhos','.eJxVjMEOwiAQRP-FsyGyq8B69O43EHYBqRqalPZk_HfbpAe9zGHem3mrEJe5hqXnKQxJXZRRh9-Oozxz20B6xHYftYxtngbWm6J32vVtTPl13d2_gxp7XddobCw-F4sW_YlQimQ20RsgEAeC4JjPAo74mJ0taNMayQpQIgJWny_hVjfn:1o3Xmr:VoWZxawJ4bBC7sbJrAhDm-eubzR1ky3kYLRux034V3I','2022-07-05 06:54:57.290657'),
 ('bymkglgotwr2x2d7813ejvao3kssjpvd','.eJxVjMEOwiAQRP-FsyGyq8B69O43EHYBqRqalPZk_HfbpAe9zGHem3mrEJe5hqXnKQxJXZRRh9-Oozxz20B6xHYftYxtngbWm6J32vVtTPl13d2_gxp7XddobCw-F4sW_YlQimQ20RsgEAeC4JjPAo74mJ0taNMayQpQIgJWny_hVjfn:1o3ujl:JEebxUh_d9QnzZz4WAooArBhvLoJvIrYoOWiwJTBA8o','2022-07-06 07:25:17.667694'),
 ('x0wq59figuulzt1smhrxtyvpjh9lyi2a','.eJxVjMEOwiAQRP-FsyGyq8B69O43EHYBqRqalPZk_HfbpAe9zGHem3mrEJe5hqXnKQxJXZRRh9-Oozxz20B6xHYftYxtngbWm6J32vVtTPl13d2_gxp7XddobCw-F4sW_YlQimQ20RsgEAeC4JjPAo74mJ0taNMayQpQIgJWny_hVjfn:1o65Us:0s9KboTDY2r1Dz6kfuAfrJidovPtZjzm05LFJdPL8g4','2022-07-12 07:18:54.531559'),
 ('0trsx67vno7zdrk8tirpsd3eiaf9rwze','.eJxVjMEOwiAQRP-FsyGyq8B69O43EHYBqRqalPZk_HfbpAe9zGHem3mrEJe5hqXnKQxJXZRRh9-Oozxz20B6xHYftYxtngbWm6J32vVtTPl13d2_gxp7XddobCw-F4sW_YlQimQ20RsgEAeC4JjPAo74mJ0taNMayQpQIgJWny_hVjfn:1o6o0M:1Yw-uCJq1peKdBVzAYjv9V7MZTH_9UPtEWnX_LtSqtg','2022-07-14 06:50:22.752873'),
 ('ujchg41hxdcud9kagtfjp0ffmr9esn3t','.eJxVjMEOwiAQRP-FsyGyq8B69O43EHYBqRqalPZk_HfbpAe9zGHem3mrEJe5hqXnKQxJXZRRh9-Oozxz20B6xHYftYxtngbWm6J32vVtTPl13d2_gxp7XddobCw-F4sW_YlQimQ20RsgEAeC4JjPAo74mJ0taNMayQpQIgJWny_hVjfn:1o6qzU:2svzDZarcwlNyDBM-k68zwPzHQ7MJgXM-xvqXoLnEhI','2022-07-14 10:01:40.858787'),
 ('wca9a7iwdhzusjv9rrk4emtftc8o5pf9','.eJxVjMEOwiAQRP-FsyGyq8B69O43EHYBqRqalPZk_HfbpAe9zGHem3mrEJe5hqXnKQxJXZRRh9-Oozxz20B6xHYftYxtngbWm6J32vVtTPl13d2_gxp7XddobCw-F4sW_YlQimQ20RsgEAeC4JjPAo74mJ0taNMayQpQIgJWny_hVjfn:1o7EWz:FKp2t0yD-Sowb9_v5FL5LOhxYuKDfVISCWv6mcJaOX0','2022-07-15 11:09:49.655701'),
 ('91kna5n4xcaklhyus9gesaqo6d6h7poc','.eJxVjMEOwiAQRP-FsyGyq8B69O43EHYBqRqalPZk_HfbpAe9zGHem3mrEJe5hqXnKQxJXZRRh9-Oozxz20B6xHYftYxtngbWm6J32vVtTPl13d2_gxp7XddobCw-F4sW_YlQimQ20RsgEAeC4JjPAo74mJ0taNMayQpQIgJWny_hVjfn:1o8K9q:9jqN7CdRIqREWr_HqSey08ZwOmkiK6Ph4uN-4-PfYPE','2022-07-18 11:22:26.432078'),
 ('enl50d1ybi82ieeafoou0nd62e8ljmdj','.eJxVjMEOwiAQRP-FsyGyq8B69O43EHYBqRqalPZk_HfbpAe9zGHem3mrEJe5hqXnKQxJXZRRh9-Oozxz20B6xHYftYxtngbWm6J32vVtTPl13d2_gxp7XddobCw-F4sW_YlQimQ20RsgEAeC4JjPAo74mJ0taNMayQpQIgJWny_hVjfn:1oBrac:4nnGrd6TbN4rE3dn1xpMRQtcRadAl2ogBCL1LlrQJq0','2022-07-28 05:40:42.957816'),
 ('smb3zn0snwkj5jpa5ijzjs5rkrrxsksk','.eJxVjMEOwiAQRP-FsyGyq8B69O43EHYBqRqalPZk_HfbpAe9zGHem3mrEJe5hqXnKQxJXZRRh9-Oozxz20B6xHYftYxtngbWm6J32vVtTPl13d2_gxp7XddobCw-F4sW_YlQimQ20RsgEAeC4JjPAo74mJ0taNMayQpQIgJWny_hVjfn:1oC1mW:Rjy4qWAQjurcACCkSVqu1cNdAHxmX89Orw0tALZwHb0','2022-07-28 16:33:40.242468'),
 ('pesxpdm6scanu3dgno18o7ml0myvwnk6','.eJxVjMEOwiAQRP-FsyGyq8B69O43EHYBqRqalPZk_HfbpAe9zGHem3mrEJe5hqXnKQxJXZRRh9-Oozxz20B6xHYftYxtngbWm6J32vVtTPl13d2_gxp7XddobCw-F4sW_YlQimQ20RsgEAeC4JjPAo74mJ0taNMayQpQIgJWny_hVjfn:1oDLDJ:N3f5VZs7MdTIc-yXrWK0eLyFUQD4F_QnP1Pv1aSiAMU','2022-08-01 07:30:45.186032'),
 ('23v0qhh35kn02ltjy96x9j4s1y0r4rs7','.eJxVjMEOwiAQRP-FsyGyq8B69O43EHYBqRqalPZk_HfbpAe9zGHem3mrEJe5hqXnKQxJXZRRh9-Oozxz20B6xHYftYxtngbWm6J32vVtTPl13d2_gxp7XddobCw-F4sW_YlQimQ20RsgEAeC4JjPAo74mJ0taNMayQpQIgJWny_hVjfn:1oDfDT:SWMcmHL5qYU4VpufTtCD4bxvAuYhAO0pZsmoy8y79gg','2022-08-02 04:52:15.054447'),
 ('oec39cp83sgl3rp6gk67vdkg0567ovf3','.eJxVjMEOwiAQRP-FsyGyq8B69O43EHYBqRqalPZk_HfbpAe9zGHem3mrEJe5hqXnKQxJXZRRh9-Oozxz20B6xHYftYxtngbWm6J32vVtTPl13d2_gxp7XddobCw-F4sW_YlQimQ20RsgEAeC4JjPAo74mJ0taNMayQpQIgJWny_hVjfn:1oE2VP:PvyQml49MILRsJK1g33F9S0LTWnmhA28R4dwaYNskk4','2022-08-03 05:44:19.101918'),
 ('ddlgjhz2dm2uohbg42wvfdwwclzbmzbg','.eJxVjMEOwiAQRP-FsyGyq8B69O43EHYBqRqalPZk_HfbpAe9zGHem3mrEJe5hqXnKQxJXZRRh9-Oozxz20B6xHYftYxtngbWm6J32vVtTPl13d2_gxp7XddobCw-F4sW_YlQimQ20RsgEAeC4JjPAo74mJ0taNMayQpQIgJWny_hVjfn:1oEPX2:P_wnU_Ipkpv5PPrvvFhxSDDFW2pR-4PyLzI3Je8W_bo','2022-08-04 06:19:32.948707'),
 ('fjzpzqvh9ajq1m3nfnt8dqunagd6gc1z','.eJxVjMEOwiAQRP-FsyGyq8B69O43EHYBqRqalPZk_HfbpAe9zGHem3mrEJe5hqXnKQxJXZRRh9-Oozxz20B6xHYftYxtngbWm6J32vVtTPl13d2_gxp7XddobCw-F4sW_YlQimQ20RsgEAeC4JjPAo74mJ0taNMayQpQIgJWny_hVjfn:1oEn90:9_UCeeb-gwg42jyWUn9h5yD4Moit1WELhtPuRAFpyEI','2022-08-05 07:32:18.240201'),
 ('mhgqtau8n6ttwfjq6vqtw3e0xyyjpbil','.eJxVjMEOwiAQRP-FsyGyq8B69O43EHYBqRqalPZk_HfbpAe9zGHem3mrEJe5hqXnKQxJXZRRh9-Oozxz20B6xHYftYxtngbWm6J32vVtTPl13d2_gxp7XddobCw-F4sW_YlQimQ20RsgEAeC4JjPAo74mJ0taNMayQpQIgJWny_hVjfn:1oFuEX:2eWrDqEPgOdPwT3WCnTEGboQNFMvvncANz2YuNo4sgA','2022-08-08 09:18:37.455973'),
 ('fu0lf38epex0qdd2x1zhen3zr29w4pao','.eJxVjMEOwiAQRP-FsyGyq8B69O43EHYBqRqalPZk_HfbpAe9zGHem3mrEJe5hqXnKQxJXZRRh9-Oozxz20B6xHYftYxtngbWm6J32vVtTPl13d2_gxp7XddobCw-F4sW_YlQimQ20RsgEAeC4JjPAo74mJ0taNMayQpQIgJWny_hVjfn:1oFuGB:7ib32IqMB_pkPvWOP9D4mDVg2MzhO7rPiEyKzGI6dgs','2022-08-08 09:20:19.474689'),
 ('14oseq8kbv5ncw7my5gnfu7n2nc1zx8e','.eJxVjMEOwiAQRP-FsyGyq8B69O43EHYBqRqalPZk_HfbpAe9zGHem3mrEJe5hqXnKQxJXZRRh9-Oozxz20B6xHYftYxtngbWm6J32vVtTPl13d2_gxp7XddobCw-F4sW_YlQimQ20RsgEAeC4JjPAo74mJ0taNMayQpQIgJWny_hVjfn:1oGDX9:kGc1D79QuAYJjR_Y32eM9iSDvnJDGBcvyfo4-ZpjGc4','2022-08-09 05:55:07.354672'),
 ('tvoa3gq1s2quxwffrp470jbcbvuc6f76','.eJxVjMEOwiAQRP-FsyGyq8B69O43EHYBqRqalPZk_HfbpAe9zGHem3mrEJe5hqXnKQxJXZRRh9-Oozxz20B6xHYftYxtngbWm6J32vVtTPl13d2_gxp7XddobCw-F4sW_YlQimQ20RsgEAeC4JjPAo74mJ0taNMayQpQIgJWny_hVjfn:1oGOpF:030Kc5U2gBC8D5uANA-LRN3riI7ocsf_r8e8BD8O15c','2022-08-09 17:58:33.823348'),
 ('5mktgrl056b83ib9b5pf91dwrwpdg5au','.eJxVjMEOwiAQRP-FsyGyq8B69O43EHYBqRqalPZk_HfbpAe9zGHem3mrEJe5hqXnKQxJXZRRh9-Oozxz20B6xHYftYxtngbWm6J32vVtTPl13d2_gxp7XddobCw-F4sW_YlQimQ20RsgEAeC4JjPAo74mJ0taNMayQpQIgJWny_hVjfn:1oGaCz:CO21HQpR6xouUvjXZZHlQS8mR1fM8zhWCHpIojx5e3E','2022-08-10 06:07:49.363163');
INSERT INTO "Applicant Guarantors" ("id","name","relation","cnic","whatsapp","email","address","years_know","photo","applicant_id","city_id","phone","cnic_photo_back","cnic_photo_front") VALUES (2,'Ibrar Hussain','Friend','123456789','03117455740','ibrar_hussain@mail.com','Pellentesque in ipsum id orci porta dapibus.',1,'gurantors/pictures/check_1_KgBawCY.png',3,1,'0311745574','gurantors/cnic/Inherent-Risks-KeyVisualjpg_DjE02C0.jpg','gurantors/cnic/Inherent-Risks-KeyVisualjpg.jpg');
INSERT INTO "Applicants" ("id","status","refrence_number","salutation","name","father_husband_name","mother_name","cnic","dob","gender","marital_status","phone","whatsapp","email","education","education_institute","job_status","residence_status","monthly_rent","mailing_address","residing_duration","current_address","profession","organization","organization_type","doj","experience","monthly_income","office_phone","office_email","office_address","previous_loan","previous_loan_deduction","monthly_expense","remarks","photo","date_added","date_updated","added_by_id","updated_by_id","monthly_other_income","education_verification") VALUES (3,1,'123456',12345,'Mian Mujeeb','Abdul Sattar','ABC XYZ','4200042634899','2022-07-18',1,5,'03117455740','03117455740','mianmujeeb@mail.com','BS Software Engineering','Minhaj University Lahore',1,2,15000,'Minhaj University Lahore',2,'Minhaj University Lahore','Software Engineer','Minhaj University Lahore',2,'2022-07-18',3,45000,'03117455740','mul@mail.com','Minhaj University Lahore',0,0,4000,'','Applicants/Mujeeb1_cFUFxni.jpg','2022-07-18 12:45:19.067583','2022-07-20 09:59:53.148248',1,1,0,'education_verification/National_Identity_Card_English.pdf');
INSERT INTO "Products" ("id","status","code","name","brand","model","price","description","date_added","date_updated","added_by_id","updated_by_id","category_id","picture") VALUES (1,1,'HONDA-70','Honda CD 70','Honda','2022',106500.0,'<p dir="ltr" style="text-align:start"><span style="font-size:14px"><span style="font-family:Lato,sans-serif"><span style="color:#434343"><span style="background-color:#ffffff"><span style="font-family:Lato,sans-serif !important"><span style="font-size:11pt"><span style="font-family:Arial"><span style="color:#000000">Honda CD 70 was formerly known as Honda 70 and is a four-stroke motorcycle manufactured by the Japanese company Honda. It was produced by Honda from 1970 to 1991 and later on, in 1991, its production moved to Atlas Honda in Pakistan.</span></span></span></span></span></span></span></span></p>

<p dir="ltr" style="text-align:start"><span style="font-size:14px"><span style="font-family:Lato,sans-serif"><span style="color:#434343"><span style="background-color:#ffffff"><span style="font-family:Lato,sans-serif !important"><span style="font-size:11pt"><span style="font-family:Arial"><span style="color:#000000">The Honda CD 70 was introduced in the Pakistani market in 1984 and it instantly dominated the market. The CD 70 replaced the two-stroke motorcycles and Vespa which was the only popular two-wheeler at that time. The CD 70 was the first four-stroke motorcycle in Pakistan due to which it became popular very quickly. Since its launch, it has maintained the highest resale value in Pakistan.&nbsp;&nbsp;</span></span></span></span></span></span></span></span></p>

<p dir="ltr" style="text-align:start"><span style="font-size:14px"><span style="font-family:Lato,sans-serif"><span style="color:#434343"><span style="background-color:#ffffff"><span style="font-family:Lato,sans-serif !important"><span style="font-size:11pt"><span style="font-family:Arial"><span style="color:#000000">Initially, the rectangular speedometer on the Honda 70 featured gear range markings and a maximum calibration of 60 mph (97 km/h). Its claimed top speed was 58 mph (93 km/h). Over time, it went through several upgrades, both in exterior design and engine. In 1984, it was rebranded as Honda CD 70 with a modified engine, carburetor, and rear indicators.&nbsp;</span></span></span></span></span></span></span></span></p>

<p dir="ltr" style="text-align:start"><span style="font-size:14px"><span style="font-family:Lato,sans-serif"><span style="color:#434343"><span style="background-color:#ffffff">&nbsp;</span></span></span></span></p>

<p dir="ltr" style="text-align:start"><span style="font-size:14px"><span style="font-family:Lato,sans-serif"><span style="color:#434343"><span style="background-color:#ffffff"><span style="font-family:Lato,sans-serif !important"><span style="font-size:11pt"><span style="font-family:Arial"><span style="color:#000000">Currently, the engine of Honda 70 is a certified Euro II engine and goes a long way if taken care of properly. The </span></span></span></span><span style="font-size:14.6667px"><span style="font-family:Arial"><span style="color:#000000">new </span></span></span><span style="font-size:14.6667px"><span style="font-family:Arial"><span style="color:#000000">model</span></span></span><span style="font-family:Lato,sans-serif !important"><span style="font-size:11pt"><span style="font-family:Arial"><span style="color:#000000"> Honda CD 70 </span></span></span></span><span style="font-size:14.6667px"><span style="font-family:Arial"><span style="color:#000000">2022 </span></span></span><span style="font-family:Lato,sans-serif !important"><span style="font-size:11pt"><span style="font-family:Arial"><span style="color:#000000">has been unveiled recently and according to Honda, the new model has 101 changes in design and engine combined.&nbsp;</span></span></span></span></span></span></span></span></p>

<h3 dir="ltr" style="text-align:start"><span style="font-size:16px"><span style="font-family:Lato,sans-serif"><strong><span style="color:#233d7b"><span style="background-color:#ffffff"><span style="font-family:Lato,sans-serif !important"><span style="font-size:14pt"><span style="font-family:Arial"><span style="color:#434343">Honda CD 70 Specs</span></span></span></span></span></span></strong></span></span></h3>

<p dir="ltr" style="text-align:start"><span style="font-size:14px"><span style="font-family:Lato,sans-serif"><span style="color:#434343"><span style="background-color:#ffffff"><span style="font-family:Lato,sans-serif !important"><span style="font-size:11pt"><span style="font-family:Arial"><span style="color:#000000">The CD 70 2022 model has a 4-Stroke OHC Air Cooled engine with a displacement of 72 cm</span></span></span><span style="font-size:11pt"><span style="font-family:Arial"><span style="color:#000000"><span style="font-size:0.6em"><span style="font-family:Lato,sans-serif !important">3</span></span></span></span></span><span style="font-size:11pt"><span style="font-family:Arial"><span style="color:#000000"> and bore and stroke of 47.0 x 41.4 mm respectively. Its dimensions are 1897 x 751 x 1014 mm with a ground clearance of 136 mm. It has a 4 Speed Constant Mesh transmission and comes with Multiple Wet Clutch Plates.</span></span></span></span></span></span></span></span></p>

<p dir="ltr" style="text-align:start"><span style="font-size:14px"><span style="font-family:Lato,sans-serif"><span style="color:#434343"><span style="background-color:#ffffff"><span style="font-family:Lato,sans-serif !important"><span style="font-size:11pt"><span style="font-family:Arial"><span style="color:#000000">The compression ratio of the CD 70 is 8.8:1 and it has a dry weight of 82 kg. The front and rear tires are 2.25 &ndash; 17 (4 PR).</span></span></span></span></span></span></span></span></p>

<h3 dir="ltr" style="text-align:start"><span style="font-size:16px"><span style="font-family:Lato,sans-serif"><strong><span style="color:#233d7b"><span style="background-color:#ffffff"><span style="font-family:Lato,sans-serif !important"><span style="font-size:14pt"><span style="font-family:Arial"><span style="color:#434343">CD 70 </span></span></span></span><span style="font-family:Lato,sans-serif !important"><span style="font-size:14pt"><span style="font-family:Arial"><span style="color:#434343">Features</span></span></span></span></span></span></strong></span></span></h3>

<p dir="ltr" style="text-align:start"><span style="font-size:14px"><span style="font-family:Lato,sans-serif"><span style="color:#434343"><span style="background-color:#ffffff"><span style="font-family:Lato,sans-serif !important"><span style="font-size:11pt"><span style="font-family:Arial"><span style="color:#000000">The CD 70 2022 new model has a newly designed engine as well as new color graphics. The muffler exhaust makes the ride less noisy and a high-quality drive chain makes the ride smooth and comfortable.&nbsp;</span></span></span></span></span></span></span></span></p>

<h3 dir="ltr" style="text-align:start"><span style="font-size:16px"><span style="font-family:Lato,sans-serif"><strong><span style="color:#233d7b"><span style="background-color:#ffffff"><span style="font-family:Lato,sans-serif !important"><span style="font-size:14pt"><span style="font-family:Arial"><span style="color:#434343">Honda CD 70 </span></span></span></span><span style="font-family:Lato,sans-serif !important"><span style="font-size:14pt"><span style="font-family:Arial"><span style="color:#434343">Design</span></span></span></span></span></span></strong></span></span></h3>

<p dir="ltr" style="text-align:start"><span style="font-size:14px"><span style="font-family:Lato,sans-serif"><span style="color:#434343"><span style="background-color:#ffffff"><span style="font-family:Lato,sans-serif !important"><span style="font-size:11pt"><span style="font-family:Arial"><span style="color:#000000">The Honda 70 2022 model has a sleek design that has no noticeable differences from the previous model&rsquo;s design. The CD 70 comes with a backbone-type frame. Its design is aimed at making the vehicle look sleek while also making the ride comfortable. The comfortable seat comes with a seat bar for additional security. The new 2022 model also has some tweaks in the external design of the fuel tank and an all-new cover sticker. Both the wheels have thicker spokes than before and the rear wheel is a lot more durable.&nbsp;</span></span></span></span></span></span></span></span></p>

<p dir="ltr" style="text-align:start"><span style="font-size:14px"><span style="font-family:Lato,sans-serif"><span style="color:#434343"><span style="background-color:#ffffff"><span style="font-family:Lato,sans-serif !important"><span style="font-size:11pt"><span style="font-family:Arial"><span style="color:#000000">It is available in black and red colors.</span></span></span></span></span></span></span></span></p>

<h3 dir="ltr" style="text-align:start"><span style="font-size:16px"><span style="font-family:Lato,sans-serif"><strong><span style="color:#233d7b"><span style="background-color:#ffffff"><span style="font-family:Lato,sans-serif !important"><span style="font-size:14pt"><span style="font-family:Arial"><span style="color:#434343">CD 70 Ride &amp; Handling</span></span></span></span></span></span></strong></span></span></h3>

<p dir="ltr" style="text-align:start"><span style="font-size:14px"><span style="font-family:Lato,sans-serif"><span style="color:#434343"><span style="background-color:#ffffff"><span style="font-family:Lato,sans-serif !important"><span style="font-size:11pt"><span style="font-family:Arial"><span style="color:#000000">The new engine of the CD 70 2022 model is better making the performance of the bike a lot more efficient. The wheels have also been redesigned with thicker spokes for better stability and the rear wheel is more durable than before. Its engine is durable and comes with a 3-year warranty in case there is any issue after purchase.&nbsp;</span></span></span></span></span></span></span></span></p>

<h3 dir="ltr" style="text-align:start"><span style="font-size:16px"><span style="font-family:Lato,sans-serif"><strong><span style="color:#233d7b"><span style="background-color:#ffffff"><span style="font-family:Lato,sans-serif !important"><span style="font-size:14pt"><span style="font-family:Arial"><span style="color:#434343">Honda 70 Mileage</span></span></span></span></span></span></strong></span></span></h3>

<p dir="ltr" style="text-align:start"><span style="font-size:14px"><span style="font-family:Lato,sans-serif"><span style="color:#434343"><span style="background-color:#ffffff"><span style="font-family:Lato,sans-serif !important"><span style="font-size:11pt"><span style="font-family:Arial"><span style="color:#000000">The CD 70 Motorcycle has an impressive mileage of </span></span></span><span style="font-size:11pt"><span style="font-family:Arial"><span style="color:#000000"><strong>70 km/l </strong></span></span></span><span style="font-size:11pt"><span style="font-family:Arial"><span style="color:#000000">(company claimed) which is suitable for daily use. It comes with a fuel capacity of 8.5 liters and reserves 1 liter of petrol.&nbsp;&nbsp;</span></span></span></span></span></span></span></span></p>

<h3 dir="ltr" style="text-align:start"><span style="font-size:16px"><span style="font-family:Lato,sans-serif"><strong><span style="color:#233d7b"><span style="background-color:#ffffff"><span style="font-family:Lato,sans-serif !important"><span style="font-size:14pt"><span style="font-family:Arial"><span style="color:#434343">Honda CD 70 Resale</span></span></span></span></span></span></strong></span></span></h3>

<p dir="ltr" style="text-align:start"><span style="font-size:14px"><span style="font-family:Lato,sans-serif"><span style="color:#434343"><span style="background-color:#ffffff"><span style="font-family:Lato,sans-serif !important"><span style="font-size:11pt"><span style="font-family:Arial"><span style="color:#000000">The Honda CD 70 bike always has had a high resale value in the Pakistani market and similar is the case with CD 70 2022 model. If it has been kept in a good condition, it can be resold instantly and at a great price.&nbsp;</span></span></span></span></span></span></span></span></p>

<h3 dir="ltr" style="text-align:start"><span style="font-size:16px"><span style="font-family:Lato,sans-serif"><strong><span style="color:#233d7b"><span style="background-color:#ffffff"><span style="font-family:Lato,sans-serif !important"><span style="font-size:14pt"><span style="font-family:Arial"><span style="color:#434343">CD 70 Competitors</span></span></span></span></span></span></strong></span></span></h3>

<p dir="ltr" style="text-align:start"><span style="font-size:14px"><span style="font-family:Lato,sans-serif"><span style="color:#434343"><span style="background-color:#ffffff"><span style="font-family:Lato,sans-serif !important"><span style="font-size:11pt"><span style="font-family:Arial"><span style="color:#000000">Honda CD 70 had no competitors when it had been initially launched back in 1984 but now the Pakistani market has been saturated with several companies introducing their own versions of CD 70. These competitors include </span></span></span><span style="font-size:11pt"><span style="font-family:Arial"><span style="color:#000000"><strong>United US70, Super Power SP 70, Road Prince Classic 70.</strong></span></span></span></span></span></span></span></span></p>

<p dir="ltr" style="text-align:start"><span style="font-size:14px"><span style="font-family:Lato,sans-serif"><span style="color:#434343"><span style="background-color:#ffffff"><span style="color:#000000"><span style="font-family:Arial,Helvetica,sans-serif"><span style="font-size:14.6667px"><span style="font-family:Lato,sans-serif !important">Only due to these competitors Honda CD 70 price has relatively been under control, otherwise, it would have sky-rocketed much sooner. For instance, the price of CD 70 back in 2005 was around PKR 54,000 and it stayed around the PKR 63,000 mark until 2017, only after which the bike prices have soared recently.</span></span></span></span></span></span></span></span></p>

<p dir="ltr" style="text-align:start"><span style="font-size:14px"><span style="font-family:Lato,sans-serif"><span style="color:#434343"><span style="background-color:#ffffff"><span style="font-family:Lato,sans-serif !important"><span style="font-size:11pt"><span style="font-family:Arial"><span style="color:#000000">The United US70 shares similar features with the Honda CD 70. They both have the same fuel capacity and similar mileage. Their performance is also identical which makes US70 a strong competitor.</span></span></span></span></span></span></span></span></p>

<p dir="ltr" style="text-align:start"><span style="font-size:14px"><span style="font-family:Lato,sans-serif"><span style="color:#434343"><span style="background-color:#ffffff"><span style="font-family:Lato,sans-serif !important"><span style="font-size:11pt"><span style="font-family:Arial"><span style="color:#000000">On the other hand, Road Prince Classic 70cc comes with a larger fuel tank with a fuel capacity of 11 liters but its mileage is 65 km/l which is less than that of CD 70.&nbsp;</span></span></span></span></span></span></span></span></p>','2022-06-30 12:00:17.041909','2022-07-20 07:45:41.373733',1,1,1,NULL);
INSERT INTO "Financing Modes" ("id","status","name","description") VALUES (1,1,'Dummy','Nulla porttitor accumsan tincidunt.'),
 (2,1,'Dummy 1','Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui.');
INSERT INTO "finance_applicantproduct" ("id","financing_amount","security_amount","tenure","rent","installment_start_date","emi","date_added","date_updated","added_by_id","applicant_id","financing_mode_id","product_id","updated_by_id") VALUES (6,100000,10000,24,30,'2022-08-01',-5591,'2022-07-27 08:01:36.143439','2022-07-27 08:01:36.143439',1,3,1,1,NULL);
INSERT INTO "finance_emichallanparticular" ("id","status","name","description") VALUES (1,1,'Security Amount',''),
 (2,1,'Principle Amount',''),
 (3,1,'Service Charges',''),
 (4,1,'Equal Monthly Installment',''),
 (5,1,'Late Payment Charges',''),
 (6,1,'Application Charges',''),
 (7,1,'Processing Fee',''),
 (8,1,'Registration Charges',''),
 (9,1,'Legal & Professional Charges',''),
 (10,1,'Other Charges','');
INSERT INTO "finance_emichallanprofile" ("id","title","logo") VALUES (1,'Al-Mawakhat Microfinance','challan/logo/logo_4_M7jcHJW.png');
INSERT INTO "finance_emichallanbankaccount" ("id","name","account_number","status") VALUES (2,'Habib Bank Limited','1234567890',1);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" (
	"user_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_group_id_97559544" ON "auth_user_groups" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" (
	"user_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "States_country_id_774ba854" ON "States" (
	"country_id"
);
CREATE INDEX IF NOT EXISTS "Sub States_country_id_ce3a9132" ON "Sub States" (
	"country_id"
);
CREATE INDEX IF NOT EXISTS "Sub States_state_id_f3de6ee1" ON "Sub States" (
	"state_id"
);
CREATE INDEX IF NOT EXISTS "Countries_currency_id_54f75e68" ON "Countries" (
	"currency_id"
);
CREATE INDEX IF NOT EXISTS "Countries_region_id_61922af5" ON "Countries" (
	"region_id"
);
CREATE INDEX IF NOT EXISTS "settings_city_country_id_3fd2a2a1" ON "settings_city" (
	"country_id"
);
CREATE INDEX IF NOT EXISTS "settings_city_state_id_508d0381" ON "settings_city" (
	"state_id"
);
CREATE INDEX IF NOT EXISTS "settings_city_sub_state_id_757409b3" ON "settings_city" (
	"sub_state_id"
);
CREATE INDEX IF NOT EXISTS "Applicant Bank Accounts_applicant_id_ddbf3220" ON "Applicant Bank Accounts" (
	"applicant_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
CREATE INDEX IF NOT EXISTS "Applicant Guarantors_applicant_id_642b5003" ON "Applicant Guarantors" (
	"applicant_id"
);
CREATE INDEX IF NOT EXISTS "Applicant Guarantors_city_id_61bbc301" ON "Applicant Guarantors" (
	"city_id"
);
CREATE INDEX IF NOT EXISTS "Applicants_added_by_id_e1b5e597" ON "Applicants" (
	"added_by_id"
);
CREATE INDEX IF NOT EXISTS "Applicants_updated_by_id_f1a9e8de" ON "Applicants" (
	"updated_by_id"
);
CREATE INDEX IF NOT EXISTS "Products_added_by_id_3fa19696" ON "Products" (
	"added_by_id"
);
CREATE INDEX IF NOT EXISTS "Products_updated_by_id_7cf32b63" ON "Products" (
	"updated_by_id"
);
CREATE INDEX IF NOT EXISTS "Products_category_id_448621b5" ON "Products" (
	"category_id"
);
CREATE INDEX IF NOT EXISTS "finance_applicantproduct_added_by_id_4df2ccdf" ON "finance_applicantproduct" (
	"added_by_id"
);
CREATE INDEX IF NOT EXISTS "finance_applicantproduct_applicant_id_7f658c8d" ON "finance_applicantproduct" (
	"applicant_id"
);
CREATE INDEX IF NOT EXISTS "finance_applicantproduct_financing_mode_id_cbaa1b9f" ON "finance_applicantproduct" (
	"financing_mode_id"
);
CREATE INDEX IF NOT EXISTS "finance_applicantproduct_product_id_52a3ddc8" ON "finance_applicantproduct" (
	"product_id"
);
CREATE INDEX IF NOT EXISTS "finance_applicantproduct_updated_by_id_90a8ba24" ON "finance_applicantproduct" (
	"updated_by_id"
);
CREATE INDEX IF NOT EXISTS "finance_applicantproductchallandetail_challan_id_90d79bdd" ON "finance_applicantproductchallandetail" (
	"challan_id"
);
CREATE INDEX IF NOT EXISTS "finance_applicantproductchallandetail_particular_id_d2797e96" ON "finance_applicantproductchallandetail" (
	"particular_id"
);
CREATE INDEX IF NOT EXISTS "finance_applicantproductchallan_applicant_id_7493df60" ON "finance_applicantproductchallan" (
	"applicant_id"
);
CREATE INDEX IF NOT EXISTS "finance_applicantproductchallan_product_id_eb07e01c" ON "finance_applicantproductchallan" (
	"product_id"
);
COMMIT;
