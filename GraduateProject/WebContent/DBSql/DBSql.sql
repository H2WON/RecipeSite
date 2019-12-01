desc Member;
select * from Member;

select * from Recipe;
create table Member(
Member_Id varchar(30) not null primary key,
Member_PassWord varchar(15) not null,
Member_Name varchar(20) not null,
Member_Manager boolean,
Member_Register datetime  
);

create table Follow(
Follow_Id int not null AUTO_INCREMENT primary key,
Follow_Sender varchar(30),
Follow_Recipient varchar(30),
Follow_Date datetime
);

create table Recipe
(Recipe_No int Not Null auto_increment,
Recipe_Title varchar(255),
Recipe_Introduce varchar(255),
Recipe_ThumbnailOriginalName varchar(255),
Recipe_ThumbnailChangeName varchar(255),
Recipe_ThumbnailSavePath varchar(255),
Recipe_VideoUrl varchar(255),
Recipe_TypeCategory int,
Recipe_SituationCategory int,
Recipe_MaterialCategory int,
Recipe_PersonnelInfo varchar(100) ,
Recipe_TimeInfo varchar(100),
Recipe_DifficultyInfo varchar(100),
Recipe_CookingTips varchar(255),
Recipe_Writer varchar(30),
Recipe_Date datetime,
Primary key(Recipe_No),
Foreign key (Recipe_TypeCategory) References RecipeTypeCategory(RecipeTypeCategory_No),
Foreign key (Recipe_SituationCategory) References RecipeSituationCategory (RecipeSituationCategory_No),
Foreign key (Recipe_MaterialCategory) References RecipeMaterialCategory (RecipeMaterialCategory_No));

create table Recipe_Ingredient
(Recipe_No int,
Recipe_IngredientNo int Not Null,
Recipe_IngredientName varchar(255), 
Recipe_IngredientQuantity varchar(255),
primary key(Recipe_No,Recipe_IngredientNo),
foreign key (Recipe_No) References Recipe (Recipe_No));

create table Recipe_Cooking
(Recipe_No int,
Recipe_CookingNo int Not Null,
Recipe_CookingDescription varchar(255),
Recipe_CookingPhotoOriginalName varchar(255),
Recipe_CookingPhotoChangeName varchar(255),
Recipe_CookingPhotoSavePath varchar(255),
Primary key(Recipe_No,Recipe_CookingNo),
Foreign key (Recipe_No) References Recipe (Recipe_No));

create table Recipe_FinishedPhoto
(Recipe_No int,
Recipe_FinishedPhotoNo int,
Recipe_FinishedPhotoOriginalName varchar(255),
Recipe_FinishedPhotoChangeName varchar(255),
Recipe_FinishedPhotoSavePath varchar(255),
Primary key(Recipe_No,Recipe_FinishedPhotoNo),
Foreign key (Recipe_No) References Recipe (Recipe_No));

create table RecipeTypeCategory
(RecipeTypeCategory_No  int primary key,
RecipeTypeCategory_Name  varchar(100));

create table RecipeSituationCategory
(RecipeSituationCategory_No  int primary key,
RecipeSituationCategory_Name  varchar(100));

create table RecipeMaterialCategory
(RecipeMaterialCategory_No int primary key,
RecipeMaterialCategory_Name  varchar(100));

insert into RecipeTypeCategory(RecipeTypeCategory_No,RecipeTypeCategory_Name) values(1,'국');
insert into RecipeTypeCategory(RecipeTypeCategory_No,RecipeTypeCategory_Name) values(2,'탕');
insert into RecipeTypeCategory(RecipeTypeCategory_No,RecipeTypeCategory_Name) values(3,'찜');
insert into RecipeTypeCategory(RecipeTypeCategory_No,RecipeTypeCategory_Name) values(4,'찌개');
insert into RecipeTypeCategory(RecipeTypeCategory_No,RecipeTypeCategory_Name) values(5,'반찬');
insert into RecipeTypeCategory(RecipeTypeCategory_No,RecipeTypeCategory_Name) values(6,'밥');
insert into RecipeTypeCategory(RecipeTypeCategory_No,RecipeTypeCategory_Name) values(7,'죽');
insert into RecipeTypeCategory(RecipeTypeCategory_No,RecipeTypeCategory_Name) values(8,'면');
insert into RecipeTypeCategory(RecipeTypeCategory_No,RecipeTypeCategory_Name) values(9,'퓨전');
insert into RecipeTypeCategory(RecipeTypeCategory_No,RecipeTypeCategory_Name) values(10,'빵');
insert into RecipeTypeCategory(RecipeTypeCategory_No,RecipeTypeCategory_Name) values(11,'샐러드');
insert into RecipeTypeCategory(RecipeTypeCategory_No,RecipeTypeCategory_Name) values(12,'디저트');

insert into RecipeSituationCategory(RecipeSituationCategory_No,RecipeSituationCategory_Name) values(1,'일상');
insert into RecipeSituationCategory(RecipeSituationCategory_No,RecipeSituationCategory_Name) values(2,'손님접대');
insert into RecipeSituationCategory(RecipeSituationCategory_No,RecipeSituationCategory_Name) values(3,'영양식');
insert into RecipeSituationCategory(RecipeSituationCategory_No,RecipeSituationCategory_Name) values(4,'초스피드');
insert into RecipeSituationCategory(RecipeSituationCategory_No,RecipeSituationCategory_Name) values(5,'다이어트');
insert into RecipeSituationCategory(RecipeSituationCategory_No,RecipeSituationCategory_Name) values(6,'이유식');
insert into RecipeSituationCategory(RecipeSituationCategory_No,RecipeSituationCategory_Name) values(7,'도시락');
insert into RecipeSituationCategory(RecipeSituationCategory_No,RecipeSituationCategory_Name) values(8,'간식');

insert into RecipeMaterialCategory(RecipeMaterialCategory_No,RecipeMaterialCategory_Name) values(1,'육류');
insert into RecipeMaterialCategory(RecipeMaterialCategory_No,RecipeMaterialCategory_Name) values(2,'해물류'); 
insert into RecipeMaterialCategory(RecipeMaterialCategory_No,RecipeMaterialCategory_Name) values(3,'채소류');
insert into RecipeMaterialCategory(RecipeMaterialCategory_No,RecipeMaterialCategory_Name) values(4,'곡류');
insert into RecipeMaterialCategory(RecipeMaterialCategory_No,RecipeMaterialCategory_Name) values(5,'버섯류');
insert into RecipeMaterialCategory(RecipeMaterialCategory_No,RecipeMaterialCategory_Name) values(6,'건어물류');
insert into RecipeMaterialCategory(RecipeMaterialCategory_No,RecipeMaterialCategory_Name) values(7,'달걀');
insert into RecipeMaterialCategory(RecipeMaterialCategory_No,RecipeMaterialCategory_Name) values(8,'유제품');

