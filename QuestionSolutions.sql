CREATE OR REPLACE PACKAGE youtubeData AS

  FUNCTION HighestViewCount RETURN videoKeyword;
  FUNCTION Engagement (OUT videoKeyword VARCHAR2(35), OUT videoAge NUMBER);

END;

# Question 1: Which type of video has the most number of views?
create or replace function HighestViewCount
    return varchar2
as
    highestVideo varchar2(35);
begin
    select userhistory.videoKeyword
        into highestVideo
    from UserHistory 
    inner join on UserInteractions.UserID=UserHistory.UserID
    order by UserInteractions.numberOfViews
    fetch first row only;
    
    return highestVideo;
end NUMBER_OF_EMPLOYEES;

# test function
DECLARE
  highestViewedVideoType varchar2(35);
BEGIN
  highestViewedVideoType := HighestViewCount();
  DBMS_OUTPUT.PUT_LINE('The videos with the highest views are ' || highestViewedVideoType);
END;


  
# Question 2

CREATE OR REPLACE PROCEDURE GetPopularVideosByAge AS
BEGIN
    FOR AgeRangeInfo IN (SELECT DISTINCT AgeRange FROM UserInfo)
    LOOP
        FOR VideoInfo IN (
            SELECT
                UserInfo.AgeRange,
                UserHistory.VideoKeyword,
                MAX(UserInteractions.NumberOfLikes) AS MaxLikes
            FROM UserInfo
            JOIN UserHistory ON UserInfo.UserID = UserHistory.UserID
            JOIN UserInteractions ON UserInteractions.UserID = UserHistory.UserID
            WHERE UserInfo.AgeRange = AgeRangeInfo.AgeRange
            GROUP BY UserInfo.AgeRange, UserHistory.VideoKeyword
        )
        LOOP
            DBMS_OUTPUT.PUT_LINE('Age Range: ' || AgeRangeInfo.AgeRange || ', Video Keyword: ' || VideoInfo.VideoKeyword || ', Max Likes: ' || VideoInfo.MaxLikes);
        END LOOP;
    END LOOP;
END GetPopularVideosByAge;
/


  
  
# Question 3: Which type of video has the highest engagement (comments + likes) and how does this correlate with the age of the viewer?
create or replace function Engagement
    (VideoType Out varchar2 (35),
    VideoAge Out number)
as
    VideoType varchar2(35);
    VideoAge number;
begin
    select userhistory.videoKeyword into VideoType, userinfo.age into VideoAge
    from UserHistory 
    inner join on UserInteractions.UserID=UserHistory.UserID
    inner join on UserHistory.UserId = UserInfo.UserID
    where max(UserInteractions.numberOfLikes + UserInteractions.numberOfComments)
    
    return VideoType, VideoAge;
end NUMBER_OF_EMPLOYEES;

# test function
DECLARE
    VideoType VARCHAR2(35);
    VideoAge NUMBER;
BEGIN
    Engagement(VideoType, VideoAge);
    DBMS_OUTPUT.PUT_LINE('Video with highest engagement: ' || VideoType || ' (Age: ' || VideoAge || ')');
END;


# Question 7 

CREATE OR REPLACE PROCEDURE GetMostInteractiveVideos AS
BEGIN
    FOR VideoInfo IN (
        SELECT
            UserHistory.VideoKeyword,
            SUM(UserInteractions.NumberOfLikes) AS TotalLikes,
            SUM(UserInteractions.NumberOfComments) AS TotalComments,
            SUM(UserInteractions.NumberOfSubscriptions) AS TotalSubscriptions
        FROM UserHistory
        JOIN UserInteractions ON UserInteractions.UserID = UserHistory.UserID
        GROUP BY UserHistory.VideoKeyword
        ORDER BY TotalLikes DESC, TotalComments DESC, TotalSubscriptions DESC
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Video Keyword: ' || VideoInfo.VideoKeyword || ', Total Likes: ' || VideoInfo.TotalLikes || ', Total Comments: ' || VideoInfo.TotalComments || ', Total Subscriptions: ' || VideoInfo.TotalSubscriptions);
    END LOOP;
END GetMostInteractiveVideos;
/

# Question 8 

CREATE OR REPLACE PROCEDURE GetAverageCommentsPerVideo AS
BEGIN
    FOR VideoInfo IN (
        SELECT
            UserHistory.VideoKeyword,
            AVG(UserInteractions.NumberOfComments) AS AvgComments
        FROM UserHistory
        JOIN UserInteractions ON UserInteractions.UserID = UserHistory.UserID
        GROUP BY UserHistory.VideoKeyword
        ORDER BY AvgComments DESC
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Video Keyword: ' || VideoInfo.VideoKeyword || ', Average Comments: ' || VideoInfo.AvgComments);
    END LOOP;
END GetAverageCommentsPerVideo;
/
