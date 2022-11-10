
--1.

select firstname||' '||lastname as "name", bibnumber, countrycode
from public.runner r
inner join public."user" u on u.email = r.email 
inner join public.registration r2 on r.runnerid = r2.runnerid 
inner join public.registrationevent r3 on r2.registrationid = r3.registrationid  
inner join public."event" e on e.eventid = r3.eventid 
where marathonid = 5;

--2.

select firstname||' '||lastname as "name", bibnumber,g.gender, date_part('year', age(dateofbirth)) as dateofbirth , countryname, eventname
from public.runner r
inner join public.country c on c.countrycode = r.countrycode 
inner join public.gender g on r.gender = g.genderid 
inner join public."user" u on r.email = u.email 
inner join public.registration r2 on r.runnerid = r2.runnerid 
inner join public.registrationevent r3 on r2.registrationid = r3.registrationid
inner join public."event" e on r3.eventid = e.eventid 
inner join public.marathon m on e.marathonid = m.marathonid 
where e.marathonid < 5
order by "name";

--3.

select g.gender, marathonname, eventname
from public.marathon m
inner join public."event" e on m.marathonid = e.marathonid 
inner join public.registrationevent r on r.eventid = e.eventid 
inner join public.registration r2 on  r.registrationid = r2.registrationid 
inner join public.runner r3 on r3.runnerid = r2.runnerid 
inner join public.gender g on g.genderid = r3.gender
where g.gender='Female';

select g.gender, marathonname, eventname
from public.marathon m
inner join public."event" e on m.marathonid = e.marathonid 
inner join public.registrationevent r on r.eventid = e.eventid 
inner join public.registration r2 on  r.registrationid = r2.registrationid 
inner join public.runner r3 on r3.runnerid = r2.runnerid 
inner join public.gender g on g.genderid = r3.gender
where g.gender='Male';

--4.

select eventname, count(bibnumber) as countrunner, avg(racetime) as avgracetime
from public.registrationevent r 
inner join public."event" e on e.eventid = r.eventid 
where racetime notnull
group by eventname;

select firstname||' '||lastname as "name", countryname, to_char((racetime||'second')::interval,'HH24:MI:SS') as racetime, date_part('year', age(dateofbirth) - age(startdatetime)) as marathonage, eventtypename, marathonname
from public.runner r 
inner join public."user" u on r.email = u.email 
inner join public.country c on c.countrycode = r.countrycode  
inner join public.registration r2 on r2.runnerid = r.runnerid 
inner join public.registrationevent r3 on r3.registrationid = r2.registrationid 
inner join public."event" e on e.eventid = r3.eventid
inner join public.marathon m on m.marathonid = e.marathonid 
inner join public.eventtype et on e.eventtypeid = et.eventtypeid 
where racetime notnull;

--5.

select firstname||' '||lastname as "name", u.email, registrationstatus, marathonname
from public."user" u  
inner join public.runner r on r.email = u.email 
inner join public.registration r2 on r2.runnerid = r.runnerid 
inner join public.registrationevent r3 on r3.registrationid =r2.registrationid 
inner join public."event" e on r3.eventid = e.eventid 
inner join public.marathon m on m.marathonid = e.marathonid 
inner join public.registrationstatus r4 on r4.registrationstatusid = r2.registrationstatusid;

--6.

select charityname, count(sponsorname) as sponsorcount, sum(amount) as sumamount
from public.sponsorship s
inner join public.registration r on r.registrationid = s.registrationid 
inner join public.charity c on c.charityid = r.charityid 
group by charityname;

--7.

select distinct "password" 
from 
	(select "password" ,regexp_matches("password",'[0-9][A-Z][@|!|#|$|%|^]','c')
	from public."user") as t
where "password" like '_____%';


 


