use projectt;

-- Numbers of rows counting from dataset

select count(*) from covid;
select count(*) from covid_1;
select count(*) from covid_2;

-- Total avg precentage of confirmed cases from the dataset

select sum(Confirmed) from covid;
select avg(Confirmed)/sum(Confirmed)*100 from covid;

-- Counting of State column from dataset

select count(distinct(state)) from covid;

-- Confirmed covid case in each State(column) in percentage

select state,sum(Confirmed)/6103*100 as confirmed_percentage from covid group by state order by confirmed_percentage desc ;

-- Total no of people cured in each State(column) in percentage

select State,sum(cured)/486*100 as Cured_percentage from covid group by state order by Cured_percentage desc;

-- Total no of deaths in each State(column) in percentage

select state,sum(deaths)/109*100 as Death_percentage from covid group by state order by Death_percentage desc;

-- Total no of positive case found on each date

select sum(Confirmed) from covid; 
select date,sum(confirmed)/6103*100 as positive_case,state from covid group by state order by positive_case desc;

-- Total no of First_Dose_Administered and Second_Dose_Administered

select sum(First_Dose_Administered),sum(Second_Dose_Administered)from covid_1;

-- Total Male_Doses_Administered and Female_Doses_Administered and Transgender_Doses_Administered

-- Total no of people administered from dataset
select sum(Male_Doses_Administered)+sum(Female_Doses_Administered)+sum(Transgender_Doses_Administered) from covid_1;

-- Outof avg vaccination male vaccinated 

select Updated_On,Male_Vaccinated,avg(Total_Vaccinated)*100 as Avg_vaccinated from covid_1 group by Male_Vaccinated order by Avg_vaccinated desc;

-- Outof avg vaccination Female vaccinated

select Updated_On,Female_Vaccinated,avg(Total_Vaccinated)*100 as Avg_vaccinated from covid_1 group by Female_Vaccinated order by Avg_vaccinated desc;

-- Total no of male,female,transgender vaccinated

select sum(Male_Vaccinated),sum(Female_Vaccinated),sum(Transgender_Vaccinated) from covid_1;

-- Top 5 State of positive case 

select state,Positive,sum(TotalSamples) from covid_2 group by State order by Positive desc limit 5;

-- Top 5 State of negative case

select state,Negative,sum(TotalSamples) from covid_2 group by State order by Negative desc limit 5;

-- Avg of total_sample of top 5 state

select state,round(avg(TotalSamples)) as Avg_sample from covid_2 group by state order by Avg_sample desc limit 5;

-- Finding total samples start alphabet with (M and U)

select distinct(state),TotalSamples from covid_2 where state like'm%' or state like'u%' ;

-- cross joining covid table and covid_1 table to find cured,deaths and total vaccinated

select cured,deaths,Total_Vaccinated from covid cross join covid_1 on covid_1.state=covid.state;

-- Covaxin_Doses_Administered and CoviShield_Dosez_Administered given to positive by cross joining

select Covaxin_Doses_Administered,CoviShield_Dosez_Administered,round(positive/sum(Positive)*100,2) 
as positive_percentage from covid_2  cross join covid_1 on covid_2.State=covid_1.State group by Positive 
order by positive_percentage desc;

-- Total no of male,female,transgender in each state by using join

select distinct(State),sum(Male_Vaccinated),sum(Female_Vaccinated),sum(Transgender_Vaccinated) 
from covid_2 cross join covid_1 on covid_2.State=covid_1.State;
 
-- Total no of positive confirmed in each state and Total vaccinated
 
select states,confirmed,Total_Vaccinated from covid cross join covid_1 on covid.Sno=covid_1.Sno group by states;

-- Total no of male,female,transgender are positive and negative percentage by using join

select sum(Male_Vaccinated)/sum(Total_Vaccinated)*100 as Male_V_P,
sum(Female_Vaccinated)/sum(Total_Vaccinated)*100 as female_V_P,
sum(Transgender_Vaccinated)/sum(Total_Vaccinated)*100 as Transgender_V_P,
sum(Positive)/sum(TotalSamples)*100 as positive_percentage,round(sum(Negative)/sum(TotalSamples)*100,4)as negative_percentage 
from covid_1 left join covid_2 on covid_1.Sno=covid_2.Sno group by Positive and Negative having sum(Positive)>7961975;

