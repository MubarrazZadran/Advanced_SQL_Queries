-- To get the top schools names with most number of players per decade in Major league Baseball(MLB)
 
 select round(s.yearID,-1) as decade, s.schoolID, sd.name_full, count(Distinct(s.playerID)) as number_of_players
                            from schools s join school_details sd on sd.schoolID = s.schoolID
                             group by decade,s.schoolID, sd.name_full
                             order by decade,number_of_players desc;
                             
  -- To rank the schools based on number of players in MLB per decade. Use the following query. 
with decade_data as ( select round(s.yearID,-1) as decade, s.schoolID, sd.name_full, count(Distinct(s.playerID)) as number_of_players
                            from schools s join school_details sd on sd.schoolID = s.schoolID
                             group by decade,s.schoolID, sd.name_full
                             order by decade,number_of_players desc)
select *, 
Dense_rank() over (partition by decade order by number_of_players desc) as rank_schools
from decade_data;

-- To show the names of top 3 schools per decade with most players in MLB use the below query.

with top_three_schools as (with decade_data as (select round(s.yearID,-1) as decade, s.schoolID, sd.name_full, count(Distinct(s.playerID)) as number_of_players
                            from schools s join school_details sd on sd.schoolID = s.schoolID
                             group by decade,s.schoolID, sd.name_full
                             order by number_of_players desc)
						select *, 
						     Dense_Rank() over (partition by decade order by number_of_players desc) as rank_schools
                             from decade_data)
select * from top_three_schools 
where rank_schools <= 3
order by decade desc, rank_schools;



