Create Database BlogIT;
Use BlogIT;
------------------------------------------
------------ CREATE TABLE ----------------

Create Table User
(
	userId int auto_increment primary key,
    password tinytext,
    email varchar(254) unique,
    fullName nvarchar(50),
    avatar tinytext,
    bio text,
    role int -- 0 = admin
);
-- TODO: Thêm bio (DONE)

Create Table Post
(
	postId int auto_increment primary key,
    postTitle tinytext,
    postTitleUnsigned tinytext,
    postSubTitle text,
    postTime datetime,
    userId int,
    seriesId int,
    seriesOrder int,
    image tinytext,
    postContent text
); 
-- TODO: Thêm cover, order in series, bio (DONE)

Create Table PostComment
(
	commentId int auto_increment primary key,
    userId int,
    postId int,
    content text,
    commentTime datetime,
    parentId int
);

Create Table PostLike
(
	postId int,
    userId int,
    likeTime datetime,
    
    primary key (postId, userId)
);

Create Table UserSeriesList
(
	seriesId int auto_increment primary key,
    userId int,
    seriesName tinytext,
    seriesNameUnsigned tinytext
);

Create Table ReportReasonList
(
	reasonId int auto_increment primary key,
    reasonContent tinytext
);

Create Table PostReport
(
	reportId int auto_increment primary key,
    userId int,
    postId int,
    reasonId int,
    reportTime datetime
);

Create Table TagList
(
	tagId varchar(30) primary key,
    tagName nvarchar(50)
);

Create Table PostTag
(
	postId int,
    tagId varchar(30),
    
    primary key(postId, tagId)
);
use BLogIT;
select * from user