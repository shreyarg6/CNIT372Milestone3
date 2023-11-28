CREATE OR REPLACE PACKAGE youtubeData AS

  FUNCTION MostViewedVideo RETURN varchar2;
  PROCEDURE PopularVideosByAgeRange();
  PROCEDURE VideoSearchCorrelation();
  PROCEDURE InteractiveCommunities();
  PROCEDURE VideosWithMoreComments();

END;

-- Question 1: Which type of video has the most number of views?
CREATE OR REPLACE FUNCTION MostViewedVideo RETURN VARCHAR2 IS
    v_Keyword UserInteractions.Keyword%TYPE;
BEGIN
    SELECT Keyword
    INTO v_Keyword
    FROM (
        SELECT Keyword, MAX(Views) AS MaxViews
        FROM UserInteractions
        GROUP BY Keyword
    )
    WHERE ROWNUM = 1;

    RETURN v_Keyword;
END MostViewedVideo;
/


  
-- Question 2: Which type of video is most popular in each age range based on likes? (ex). (13-17)

CREATE OR REPLACE PROCEDURE PopularVideosByAgeRange IS
BEGIN
    FOR age_rec IN (SELECT DISTINCT Age FROM UserInfo) LOOP
        FOR video_rec IN (
            SELECT ui.Keyword, ui.Likes, ui.AgeRange
            FROM UserInteractions ui
            JOIN UserInfo u ON ui.UserID = u.UserID
            WHERE ui.Likes = (
                SELECT MAX(Likes)
                FROM UserInteractions
                WHERE AgeRange = age_rec.Age
                GROUP BY AgeRange
            )
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('Age Range: ' || age_rec.Age || ', Keyword: ' || video_rec.Keyword || ', Likes: ' || video_rec.Likes);
        END LOOP;
    END LOOP;
END PopularVideosByAgeRange;
/

  
  
-- Question 3: Which type of video has the highest number of searches, and how does this correlate with the time of day?
CREATE OR REPLACE PROCEDURE VideoSearchCorrelation IS
BEGIN
    FOR search_rec IN (
        SELECT Keyword, COUNT(*) AS SearchCount, TO_CHAR(Date, 'HH24') AS HourOfDay
        FROM UserInteractions
        WHERE Keyword IS NOT NULL
        GROUP BY Keyword, TO_CHAR(Date, 'HH24')
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Keyword: ' || search_rec.Keyword || ', Searches: ' || search_rec.SearchCount || ', Hour of Day: ' || search_rec.HourOfDay);
    END LOOP;
END VideoSearchCorrelation;
/


-- Question 7: Which video categories have the most interactive communities, in terms of likes, comments, and subscriptions?

CREATE OR REPLACE PROCEDURE InteractiveCommunities IS
BEGIN
    FOR comm_rec IN (
        SELECT ui.Keyword, SUM(ui.Likes) AS TotalLikes, SUM(ui.Comments) AS TotalComments, SUM(ui.Subscriptions) AS TotalSubscriptions
        FROM UserInteractions ui
        GROUP BY ui.Keyword
        ORDER BY TotalLikes DESC, TotalComments DESC, TotalSubscriptions DESC
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Keyword: ' || comm_rec.Keyword || ', Total Likes: ' || comm_rec.TotalLikes || ', Total Comments: ' || comm_rec.TotalComments || ', Total Subscriptions: ' || comm_rec.TotalSubscriptions);
    END LOOP;
END InteractiveCommunities;
/

-- Question 8: What types of videos get more comments on their videos?

CREATE OR REPLACE PROCEDURE VideosWithMoreComments IS
BEGIN
    FOR comments_rec IN (
        SELECT ui.Keyword, AVG(ui.Comments) AS AvgComments
        FROM UserInteractions ui
        GROUP BY ui.Keyword
        ORDER BY AvgComments DESC
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Keyword: ' || comments_rec.Keyword || ', Average Comments: ' || comments_rec.AvgComments);
    END LOOP;
END VideosWithMoreComments;
/
