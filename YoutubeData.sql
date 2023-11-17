CREATE TABLE UserInfo (
    UserID NUMBER PRIMARY KEY,
    Username VARCHAR2(20),
    Country VARCHAR2(20),
    Age NUMBER,
);


CREATE TABLE UserInteractions (
    VideoID NUMBER PRIMARY KEY,
    Title VARCHAR2(50),
    Keyword VARCHAR2(15),
    Likes INTEGER,
    Comments VARCHAR2(50),
    Views INTEGER
);

COPY Video(VideoID, Title, Date, Keyword, Likes, Comments, Views)
FROM 'user-history.csv'
DELIMITER '
CSV HEADER;

COPY Comments(VideoID, CommentText, Likes, Sentiment)
FROM 'user-history.csv'
DELIMITER ','
CSV HEADER;
