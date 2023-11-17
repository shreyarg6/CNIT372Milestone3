CREATE OR REPLACE PACKAGE youtubeData AS

  FUNCTION HighestViewCount RETURN videoKeyword;

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
  highestViewedVideoType;
BEGIN
  highestViewedVideoType := HighestViewCount();
  DBMS_OUTPUT.PUT_LINE('The videos with the highest views are ' || highestViewedVideoType);
END;
  
# Question 3: Which type of video has the highest engagement (comments + likes) and how does this correlate with the age of the viewer?

  
# Question 4 

# Question 7 

# Question 8 
