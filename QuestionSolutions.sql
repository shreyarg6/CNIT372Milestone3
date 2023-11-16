CREATE OR REPLACE PACKAGE youtubeData AS

  FUNCTION HighestViewCount RETURN videoKeyword;

END;

# Question 1 --------------------------------------
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
select HighestViewCount()
from dual;
  
# Question 3 --------------------------------------

# Question 4 --------------------------------------
