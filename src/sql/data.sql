Create Database BlogIT;
Use BlogIT;
------------------------------------------
------------ CREATE TABLE ----------------

Create Table Administrator
(
	id varchar(5) primary key,
    pass tinytext
);

Create Table UserInfo
(
	userName varchar(254) primary key,
    pass tinytext,
    email varchar(254) unique,
    fullName nvarchar(50),
    postAmount int,
    avatar tinytext
);

Create Table Post
(
	postId int auto_increment primary key,
    postTitle tinytext,
    postTime date,
    userName tinytext,
    likes int,
    seriesId int,
    postContent text
);

Create Table UserSeriesList
(
	seriesId int auto_increment primary key,
    userName tinytext,
    seriesName tinytext
);

Create Table PostComment
(
	commentId int auto_increment primary key,
    userName tinytext,
    postId int,
    content text,
    commentTime date,
    replyToCommentId int
);

Create Table ReportReasonList
(
	reasonId int auto_increment primary key,
    reasonContent tinytext
);

Create Table PostReport
(
	reportId int auto_increment primary key,
    userName tinytext,
    postId int,
    reasonId int,
    reportTime date
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
