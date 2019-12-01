--11/10 수정


--언니들 -> 3309 jsptest jspid jsppass
--고다혜 -> 3306 jsptest jsp2018 jsp2018



DROP TABLE IF EXISTS Member;
create table Member(
	Member_Id varchar(30) not null primary key,
	Member_PassWord varchar(15) not null,
	Member_Name varchar(20) not null,
	Member_Manager boolean,
	Member_Register datetime  
);

select * from Member;


DROP TABLE IF EXISTS Follow;
create table Follow(
	Follow_Id int not null AUTO_INCREMENT primary key,
	Follow_Sender varchar(30),
	Follow_Recipient varchar(30),
	Follow_Date datetime
);


select * from Follow;
--------------------TvRecipe----------------------
DESC TvRecipe;
DESC TvRecipeTypeCategory;
DESC TvRecipeSituationCategory;
DESC TvRecipeMaterialCategory;
DESC TvRecipeIngredient;
DESC TvRecipeCooking;
DESC TvRecipeFinishedPhoto;



SELECT * FROM TvRecipe;
SELECT * FROM TvRecipeTypeCategory;
SELECT * FROM TvRecipeSituationCategory;
SELECT * FROM TvRecipeMaterialCategory;
SELECT * FROM TvRecipeIngredient;
SELECT * FROM TvRecipeCooking;
SELECT * FROM TvRecipeFinishedPhoto;



DROP TABLE IF EXISTS TvRecipeTypeCategory;
create table TvRecipeTypeCategory(
	TvRecipeTypeCategory_No int primary key,
	TvRecipeTypeCategory_Name varchar(100)
);



DROP TABLE IF EXISTS TvRecipeSituationCategory;
create table TvRecipeSituationCategory(
	TvRecipeSituationCategory_No int primary key,
	TvRecipeSituationCategory_Name varchar(100)
);



DROP TABLE IF EXISTS TvRecipeMaterialCategory;
create table TvRecipeMaterialCategory(
	TvRecipeMaterialCategory_No int primary key,
	TvRecipeMaterialCategory_Name varchar(100)
);



insert into TvRecipeTypeCategory(TvRecipeTypeCategory_No,TvRecipeTypeCategory_Name) values(1,'한식');
insert into TvRecipeTypeCategory(TvRecipeTypeCategory_No,TvRecipeTypeCategory_Name) values(2,'양식');
insert into TvRecipeTypeCategory(TvRecipeTypeCategory_No,TvRecipeTypeCategory_Name) values(3,'중식');
insert into TvRecipeTypeCategory(TvRecipeTypeCategory_No,TvRecipeTypeCategory_Name) values(4,'일식');
insert into TvRecipeTypeCategory(TvRecipeTypeCategory_No,TvRecipeTypeCategory_Name) values(5,'동남아');
insert into TvRecipeTypeCategory(TvRecipeTypeCategory_No,TvRecipeTypeCategory_Name) values(6,'디저트');



insert into TvRecipeSituationCategory(TvRecipeSituationCategory_No,TvRecipeSituationCategory_Name) values(1,'일상');
insert into TvRecipeSituationCategory(TvRecipeSituationCategory_No,TvRecipeSituationCategory_Name) values(2,'손님접대');
insert into TvRecipeSituationCategory(TvRecipeSituationCategory_No,TvRecipeSituationCategory_Name) values(3,'영양식');
insert into TvRecipeSituationCategory(TvRecipeSituationCategory_No,TvRecipeSituationCategory_Name) values(4,'초스피드');
insert into TvRecipeSituationCategory(TvRecipeSituationCategory_No,TvRecipeSituationCategory_Name) values(5,'다이어트');
insert into TvRecipeSituationCategory(TvRecipeSituationCategory_No,TvRecipeSituationCategory_Name) values(6,'이유식');
insert into TvRecipeSituationCategory(TvRecipeSituationCategory_No,TvRecipeSituationCategory_Name) values(7,'도시락');
insert into TvRecipeSituationCategory(TvRecipeSituationCategory_No,TvRecipeSituationCategory_Name) values(8,'간식');



insert into TvRecipeMaterialCategory(TvRecipeMaterialCategory_No,TvRecipeMaterialCategory_Name) values(1,'육류');
insert into TvRecipeMaterialCategory(TvRecipeMaterialCategory_No,TvRecipeMaterialCategory_Name) values(2,'해물류'); 
insert into TvRecipeMaterialCategory(TvRecipeMaterialCategory_No,TvRecipeMaterialCategory_Name) values(3,'채소류');
insert into TvRecipeMaterialCategory(TvRecipeMaterialCategory_No,TvRecipeMaterialCategory_Name) values(4,'곡류');
insert into TvRecipeMaterialCategory(TvRecipeMaterialCategory_No,TvRecipeMaterialCategory_Name) values(5,'버섯류');
insert into TvRecipeMaterialCategory(TvRecipeMaterialCategory_No,TvRecipeMaterialCategory_Name) values(6,'건어물류');
insert into TvRecipeMaterialCategory(TvRecipeMaterialCategory_No,TvRecipeMaterialCategory_Name) values(7,'달걀');
insert into TvRecipeMaterialCategory(TvRecipeMaterialCategory_No,TvRecipeMaterialCategory_Name) values(8,'유제품');



DROP TABLE IF EXISTS TvRecipe;
create table TvRecipe(
	TvRecipe_No int Not Null auto_increment,
	TvRecipe_Title varchar(255),
	TvRecipe_Introduce varchar(255),
	TvRecipe_ThumbnailOriginalName varchar(255),
	TvRecipe_ThumbnailChangeName varchar(255),
	TvRecipe_ThumbnailSavePath varchar(255),
	TvRecipe_TypeCategory int,
	TvRecipe_SituationCategory int,
	TvRecipe_MaterialCategory int,
	TvRecipe_VideoUrl varchar(255),
	TvRecipe_PersonnelInfo varchar(100) ,
	TvRecipe_TimeInfo varchar(100),
	TvRecipe_DifficultyInfo varchar(100),
	TvRecipe_CookingTips varchar(255),
	TvRecipe_Writer varchar(30),
	TvRecipe_Date datetime,
	
	Primary key (TvRecipe_No),
	Foreign key (TvRecipe_TypeCategory) References TvRecipeTypeCategory(TvRecipeTypeCategory_No),
	Foreign key (TvRecipe_SituationCategory) References TvRecipeSituationCategory(TvRecipeSituationCategory_No),
	Foreign key (TvRecipe_MaterialCategory) References TvRecipeMaterialCategory(TvRecipeMaterialCategory_No)
);	
---TvRecipe 테이블에 데이터가 하나도 없으면 Act페이지 INSERT 안됨(코드 설계상 문제)---
INSERT INTO TvRecipe(TvRecipe_Title) VALUES('제목');



--------------------TvRecipe----------------------
DROP TABLE IF EXISTS TvRecipeIngredient;
create table TvRecipeIngredient(
	TvRecipe_No int,
	TvRecipeIngredient_No int Not Null,
	TvRecipeIngredient_Name varchar(255), 
	TvRecipeIngredient_Quantity varchar(255),
	
	primary key(TvRecipe_No,TvRecipeIngredient_No),
	foreign key (TvRecipe_No) References TvRecipe (TvRecipe_No)
);



DROP TABLE IF EXISTS TvRecipeCooking;
create table TvRecipeCooking(
	TvRecipe_No int,
	TvRecipeCooking_No int Not Null,
	TvRecipeCooking_Description varchar(255),
	TvRecipeCooking_PhotoOriginalName varchar(255),
	TvRecipeCooking_PhotoChangeName varchar(255),
	TvRecipeCooking_PhotoSavePath varchar(255),
	
	Primary key(TvRecipe_No,TvRecipeCooking_No),
	Foreign key (TvRecipe_No) References TvRecipe (TvRecipe_No)
);



DROP TABLE IF EXISTS TvRecipeFinishedPhoto;
create table TvRecipeFinishedPhoto(
	TvRecipe_No int,
	TvRecipeFinishedPhoto_No int,
	TvRecipeFinishedPhoto_OriginalName varchar(255),
	TvRecipeFinishedPhoto_ChangeName varchar(255),
	TvRecipeFinishedPhoto_SavePath varchar(255),
	
	Primary key(TvRecipe_No,TvRecipeFinishedPhoto_No),
	Foreign key (TvRecipe_No) References TvRecipe (TvRecipe_No)
);



-------------TvRecipe 관련 모든 테이블 삭제할 때-------------
--------------잠시 FK 해제하여 삭제가 편이하도록-------------
SET foreign_key_checks=0;
drop table TvRecipeTypeCategory;
SET foreign_key_checks=1;



SET foreign_key_checks=0;
drop table TvRecipeSituationCategory;
SET foreign_key_checks=1;



SET foreign_key_checks=0;
drop table TvRecipeMaterialCategory;
SET foreign_key_checks=1;



SET foreign_key_checks=0;
drop table TvRecipeIngredient;
SET foreign_key_checks=1;



SET foreign_key_checks=0;
drop table TvRecipeCooking;
SET foreign_key_checks=1;



SET foreign_key_checks=0;
drop table TvRecipeFinishedPhoto;
SET foreign_key_checks=1;



--------------------Recipe(MyRecipe)----------------------
DESC Recipe;
DESC RecipeIngredient;
DESC RecipeCooking;
DESC RecipeFinishedPhoto;



DROP TABLE IF EXISTS Recipe;
create table Recipe(
	Recipe_No int Not Null auto_increment,
	Recipe_Title varchar(255),
	Recipe_Introduce varchar(255),
	Recipe_ThumbnailOriginalName varchar(255),
	Recipe_ThumbnailChangeName varchar(255),
	Recipe_ThumbnailSavePath varchar(255),
	Recipe_VideoUrl varchar(255),
	Recipe_PersonnelInfo varchar(100) ,
	Recipe_TimeInfo varchar(100),
	Recipe_DifficultyInfo varchar(100),
	Recipe_CookingTips varchar(255),
	Recipe_Writer varchar(30),
	Recipe_Date datetime,
	
	Primary key(Recipe_No)
);



DROP TABLE IF EXISTS RecipeIngredient;
create table RecipeIngredient(
	Recipe_No int,
	RecipeIngredient_No int Not Null,
	RecipeIngredient_Name varchar(255), 
	RecipeIngredient_Quantity varchar(255),
	
	primary key(Recipe_No,RecipeIngredient_No),
	foreign key (Recipe_No) References Recipe (Recipe_No)
);



DROP TABLE IF EXISTS RecipeCooking;
create table RecipeCooking(
	Recipe_No int,
	RecipeCooking_No int Not Null,
	RecipeCooking_Description varchar(255),
	RecipeCooking_PhotoOriginalName varchar(255),
	RecipeCooking_PhotoChangeName varchar(255),
	RecipeCooking_PhotoSavePath varchar(255),
	
	Primary key(Recipe_No,RecipeCooking_No),
	Foreign key (Recipe_No) References Recipe (Recipe_No)
);



DROP TABLE IF EXISTS RecipeFinishedPhoto;
create table RecipeFinishedPhoto(
	Recipe_No int,
	RecipeFinishedPhoto_No int,
	RecipeFinishedPhoto_OriginalName varchar(255),
	RecipeFinishedPhoto_ChangeName varchar(255),
	RecipeFinishedPhoto_SavePath varchar(255),
	
	Primary key(Recipe_No,RecipeFinishedPhoto_No),
	Foreign key (Recipe_No) References Recipe (Recipe_No)
);
------------Event 관련 ------------------------------
create table Event(
	Event_Id int primary key auto_increment,
	Event_Title varchar(100),
	Event_Content Text,
	Event_StartDate date,
	Event_EndDate date,
	Event_ThumbOriginalName varchar(255),
	Event_ThumbChangeName varchar(255),
	Event_ThumbNailSavePath varchar(255)
);

drop table Event;
desc Event;
select * from Event;
delete from Event;

create table EventComment(
	EventComment_Id int primary key auto_increment,
	EventComment_Content text,
	EventComment_Date date,
	EventComment_Writer varchar(30),
	Event_Id int,
	Foreign key (Event_Id) References Event (Event_Id)
);

drop table EventComment;

------------RecipeComment-----------------------------------------
DROP TABLE IF EXISTS RecipeComment;
create table RecipeComment(
	RecipeComment_Id int primary key auto_increment,
	RecipeComment_Content text,
	RecipeComment_Date date,
	RecipeComment_Writer varchar(30),
	Recipe_No int,
	Foreign key (Recipe_No) References Recipe(Recipe_No)
);

select * from RecipeComment;

------------TVRecipeComment-----------------------------------------
DROP TABLE IF EXISTS TVRecipeComment;
create table TVRecipeComment(
	TVRecipeComment_Id int primary key auto_increment,
	TVRecipeComment_Content text,
	TVRecipeComment_Date date,
	TVRecipeComment_Writer varchar(30),
	TVRecipe_No int,
	Foreign key (TVRecipe_No) References TVRecipe(TVRecipe_No)
);

select * from TVRecipeComment;

-----------------질문테이블---------------
create table Question(
Question_Id int Not Null auto_increment,
Question_Title varchar(100),
Question_Writer varchar(50),
Question_Date datetime,
Question_Content Text,
Question_Secret Boolean,
Question_SecretPwd varchar(15),
Primary key(Question_Id));

select * from Question;

-----------------질문사진테이블---------------
create table QuestionPhoto(
Question_Id int,
QuestionPhoto_Id int,
QuestionPhoto_OriginalName varchar(255),
QuestionPhoto_ChangeName varchar(255),
QuestionPhoto_SavePath varchar(255),
Primary key(QuestionPhoto_Id, Question_Id),
Foreign key (Question_Id) References Question (Question_Id));

-----------------------질문댓글테이블----------------
create table QuestionComment(
Question_Id int,
QuestionComment_Id int auto_increment,
QuestionComment_Writer varchar(50),
QuestionComment_Content Text,
QuestionComment_Date datetime,
Primary key (QuestionComment_Id),
Foreign key (Question_Id) References Question (Question_Id));


-------------Question 관련 모든 테이블 삭제할 때-------------
---------------잠시 FK 해제하여 삭제가 편이하도록--------------
SET foreign_key_checks=0;
drop table QuestionPhoto;
SET foreign_key_checks=1;

SET foreign_key_checks=0;
drop table QuestionComment;
SET foreign_key_checks=1;

drop table Question;
drop table QuestionPhoto;

----------------기본상식카테고리------
create table RecipeSenseCategory(
RecipeSenseCategory_Id int,
RecipeSenseCategory_Name varchar(100),
Primary key(RecipeSenseCategory_Id));

insert into RecipeSenseCategory(RecipeSenseCategory_Id,RecipeSenseCategory_Name) values(1,'육류');
insert into RecipeSenseCategory(RecipeSenseCategory_Id,RecipeSenseCategory_Name) values(2,'해물류');
insert into RecipeSenseCategory(RecipeSenseCategory_Id,RecipeSenseCategory_Name) values(3,'청과류');
insert into RecipeSenseCategory(RecipeSenseCategory_Id,RecipeSenseCategory_Name) values(4,'채소류');

--------------------기본상식-----------------
create table RecipeSense(
RecipeSense_Id int Not Null auto_increment,
RecipeSense_Title varchar(255),
RecipeSense_ThumbnailOriginalName varchar(255),
RecipeSense_ThumbnailChangeName varchar(255),
RecipeSense_ThumbnailSavePath varchar(255),
RecipeSense_VideoUrl varchar(255),
RecipeSense_Category int,
RecipeSense_Writer varchar(30),
RecipeSense_Date datetime,
Primary key(RecipeSense_Id),
Foreign key (RecipeSense_Category) References RecipeSenseCategory (RecipeSenseCategory_Id));


--------------------기본상식손질순서-----------------
create table RecipeSenseStep(
RecipeSense_Id int,
RecipeSenseStep_Id int Not Null,
RecipeSenseStep_Description varchar(255),
RecipeSenseStep_PhotoOriginalName varchar(255),
RecipeSenseStep_PhotoChangeName varchar(255),
RecipeSenseStep_PhotoSavePath varchar(255),
Primary key(RecipeSense_Id, RecipeSenseStep_Id),
Foreign key (RecipeSense_Id) References RecipeSense (RecipeSense_Id));

-------------Sense 관련 모든 테이블 삭제할 때-------------
---------------잠시 FK 해제하여 삭제가 편이하도록--------------
SET foreign_key_checks=0;
drop table RecipeSenseStep;
SET foreign_key_checks=1;

SET foreign_key_checks=0;
drop table RecipeSenseCategory;
SET foreign_key_checks=1;

drop table RecipeSense;

select * from RecipeSense;

-----------------------기본상식 댓글테이블----------------
create table RecipeSenseComment(
RecipeSense_Id int,
RecipeSenseComment_Id int auto_increment,
RecipeSenseComment_Writer varchar(50),
RecipeSenseComment_Content Text,
RecipeSenseComment_Date datetime,
Primary key (RecipeSenseComment_Id),
Foreign key (RecipeSense_Id) References RecipeSense(RecipeSense_Id)
);

