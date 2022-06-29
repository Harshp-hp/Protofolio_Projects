## Viewing Data 
select * from ipl_data.deliveries;
select * from ipl_data.matches;

## shape of deliveries table
select count(*) as No_of_rows from ipl_data.deliveries;

## shape of matches table 
select count(*) as No_of_rows from ipl_data.matches;

## view selected columns
select m.season, m.city, m.date, m.team1, m.winner, m.win_by_runs from ipl_data.matches m
where m.season = "2017";

## distnct values (No of Years)
select distinct year(m.date) as 'Year of Match' from ipl_data.matches m;

## total number of matches played 
select count(distinct player_of_match) as 'No_of_Matches' from ipl_data.matches m order by 1;

## Find season winner for each season(Season winner is the winner of the last match of each season)
select distinctrow m.season, m.winner from ipl_data.matches m
order by m.season desc;

## find venue of 10 most recently played matches 

select distinct m.venue, m.date from ipl_data.matches m order by m.date desc limit 10;

## check the number of 4,6,single and duck of players
select distinct batsman,bowler,ball,
 case
 when total_runs = 1 then 'Single'
 when total_runs = 4 then 'Four'
 when total_runs = 6 then 'Six'
 else 'Duck'
 end as 'Run in Words' from ipl_data.deliveries;
 
 ## Data Aggregation 
 select winner, win_by_wickets, max(win_by_runs) from ipl_data.matches
 group by winner 
 order by 3 desc;
 
 ## how many extra runs have been conceded in ipl
 select distinct bowler,sum(extra_runs) from ipl_data.deliveries
 group by bowler
 having sum(extra_runs)>0;
 
 ## Teams won by how many runs in ipl
 
 select winner, avg(win_by_runs) from ipl_data.matches
 group by winner
 having avg(win_by_runs)>0
 order by 2 desc;
 
 ## How many extra runs were conceded in ipl by p kumar 
 select bowler,sum(extra_runs) from ipl_data.deliveries
 where bowler='P Kumar'
 group by bowler;
 
 select * from ipl_data.deliveries;
## How manu boundaries (4s abd 6s)were hits in ipl?
-- Chennai Super Kings 
select m.winner, d.total_runs, count(d.total_runs) from ipl_data.deliveries d 
inner join ipl_data.matches m on m.id = d.match_id
where d.total_runs in (4, 6)
and m.winner ='Chennai Super Kings'
group by m.winner, d.total_runs; 

-- Mumbai Indians 

select m.winner, d.total_runs, count(d.total_runs) from ipl_data.deliveries d 
inner join ipl_data.matches m on m.id = d.match_id
where d.total_runs in (4, 6)
and m.winner = 'Mumbai Indians'
group by m.winner, d.total_runs; 

-- How many balls bowled by the bowler "P Kumar"

select bowler, count(ball) from ipl_data.deliveries
where bowler = 'P Kumar'
group by bowler;

-- No. of Batsman played in IPL
select batsman from ipl_data.deliveries 
group by batsman;

-- How many balls did P Kumar bowl to the batsman Sachin Tendulkar 

select batsman, bowler, count(ball) from ipl_data.deliveries 
where bowler = 'P Kumar' and batsman =  'SR Tendulkar'
group by batsman, bowler;

-- How many balls did P Kumar bowl to batsman Virat Kohli

select batsman,bowler, count(ball) from ipl_data.deliveries 
where bowler = 'P Kumar' and batsman = 'V Kohli'
group by batsman,bowler;

-- How many matches played in the month of April 

select count(*) from ipl_data.matches 
where month(date) = '4';

-- How many matches were played in month of march and june 

select count(*) from ipl_data.matches
where month(date) in (3,6);

-- Total number of wickets taken in ipl (not count null values )

select count(player_dismissed) as 'Wicket' from ipl_data.deliveries 
where player_dismissed <>"";

select dismissal_kind, player_dismissed, count(*) from ipl_data.deliveries 
where player_dismissed <>""
group by dismissal_kind, player_dismissed
order by 3 desc;

-- Pattern Match (Like operator %)
select * from ipl_data.matches;
select distinct player_of_match from ipl_data.matches where player_of_match like '%M%';
select distinct player_of_match from ipl_data.matches where player_of_match like '%JJ%';
select distinct player_of_match from ipl_data.matches where player_of_match like '%K_P%';


-- Maximum runs by which team won a match per season

select season,max(win_by_runs) from ipl_data.matches
group by season;

-- Create a Scorecard 

select batting_team, batsman, sum(batsman_runs) from ipl_data.deliveries
group by batting_team,batsman
order by 3 desc;

-- Top 10 players with maximum boundarie hits 

select distinct batsman,count(total_runs) from ipl_data.deliveries
where total_runs in (4,6)
group by batsman
order by 2 desc
limit 10;

-- Top 20 bowlers who conceded highest extra runs 

select bowler,sum(extra_runs) as 'Highest Extra Runs' from ipl_data.deliveries 	
group by bowler 
order by 2 desc
limit 20;

-- Top 10 Wicket Takers 

select bowler,count(player_dismissed) as NoWicket_Taken, dismissal_kind from ipl_data.deliveries 
where dismissal_kind  <>""
group by bowler
order by NoWicket_Taken desc
limit 10;

-- Name and Number of wickets by bowlers who have taken more than or equal to 100 wickets in ipl

select bowler, count(player_dismissed) as NoWicket_Taken, dismissal_kind from  ipl_data.deliveries 
where dismissal_kind <>""
group by bowler
having count(player_dismissed) >= 100
order by NoWicket_Taken desc
limit 10;
