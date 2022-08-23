select distinct arbetsgivare, person.name, days_between(current_date, startdate) AS längd, count(owner) AS antbilar
from CAR FULL JOIN PERSON ON CAR.OWNER = PERSON.PID,
     XMLTABLE('$e//employment'
         PASSING employments AS "e"
         COLUMNS
         arbetsgivare VARCHAR(10) PATH '@employer',
         startdate DATE PATH '@startdate',
         enddate VARCHAR(15) PATH '@enddate'
        )
where enddate is null
group by name, arbetsgivare, startdate
order by arbetsgivare


