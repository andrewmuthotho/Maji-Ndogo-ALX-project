USE md_water_services;


SELECT * FROM data_dictionary;

-- HONOURING THE EMPLOYEES
SELECT assigned_employee_id, SUM(visit_count) FROM visits GROUP BY assigned_employee_id ORDER BY SUM(visit_count) DESC LIMIT 3;
SELECT employee_name,phone_number,email FROM employee WHERE assigned_employee_id IN (1, 30, 34);

-- ANALYZING LOCATIONS
SELECT * FROM location;
SELECT town_name, COUNT(location_id) AS Records_per_town FROM location GROUP BY town_name;
SELECT province_name, COUNT(location_id) AS Records_per_province FROM location GROUP BY province_name;

SELECT province_name, town_name, COUNT(location_id) AS Records_per_town FROM location GROUP BY  town_name, province_name ORDER BY province_name, COUNT(location_id) DESC;
SELECT location_type, COUNT(location_id) AS Records_per_location FROM location GROUP BY location_type;
SELECT 23740 / (15910 + 23740) * 100;

-- DIVING INTO THE SOURCES
SELECT * FROM water_source;
SELECT SUM(number_of_people_served) FROM water_source;
SELECT type_of_water_source, COUNT(source_id) AS number_of_people_served_per_source FROM water_source GROUP BY type_of_water_source;
SELECT type_of_water_source, ROUND(AVG(number_of_people_served),0) AS avg_of_people_served_per_source FROM water_source GROUP BY type_of_water_source;
SELECT type_of_water_source, SUM(number_of_people_served) AS No_of_people_served_per_source FROM water_source GROUP BY type_of_water_source ORDER BY SUM(number_of_people_served) DESC;
SELECT type_of_water_source, ROUND((SUM(number_of_people_served)/ 27628140)*100, 0) AS Percentage_of_people_served_per_source FROM water_source GROUP BY type_of_water_source ORDER BY SUM(number_of_people_served) DESC;

-- START OF A SOLUTION


-- ANALYSING QUEUES

SELECT * FROM visits;
SELECT COUNT(time_of_record) FROM visits;
SELECT DATEDIFF( MAX(time_of_record), MIN(time_of_record)) AS days_elapse FROM visits;
SELECT AVG(time_in_queue) FROM visits WHERE NULLIF(time_in_queue,0);
SELECT DAYNAME(time_of_record), ROUND(AVG(time_in_queue),0) FROM visits WHERE NULLIF(time_in_queue,0) GROUP BY DAYNAME(time_of_record) ORDER BY ROUND(AVG(time_in_queue),0) ASC;
SELECT HOUR(time_of_record), ROUND(AVG(time_in_queue),0) FROM visits WHERE NULLIF(time_in_queue,0) GROUP BY HOUR(time_of_record) ORDER BY HOUR(time_of_record) ASC;
SELECT TIME_FORMAT(TIME(time_of_record), '%H:00') AS hour_of_day, ROUND(AVG(time_in_queue),0) FROM visits WHERE NULLIF(time_in_queue,0) GROUP BY TIME_FORMAT(TIME(time_of_record), '%H:00') ORDER BY TIME_FORMAT(TIME(time_of_record), '%H:00') ASC;

SELECT 
	TIME_FORMAT(TIME(time_of_record), '%H:00') AS hour_of_day,
    
    -- SUNDAY
    ROUND(AVG(
		CASE
        WHEN DAYNAME(time_of_record) = 'Sunday' THEN time_in_queue
        ELSE NULL
	END 
        ),0) AS Sunday,
        
	-- MONDAY
    ROUND(AVG(
		CASE
        WHEN DAYNAME(time_of_record) = 'Monday' THEN time_in_queue
        ELSE NULL
	END 
        ),0) AS Monday,
        
        -- TUESDAY
    ROUND(AVG(
		CASE
        WHEN DAYNAME(time_of_record) = 'Tuesday' THEN time_in_queue
        ELSE NULL
	END 
        ),0) AS Tuesday,
        
	-- WEDNESDAY 
    ROUND(AVG(
		CASE
        WHEN DAYNAME(time_of_record) = 'Wednesday' THEN time_in_queue
        ELSE NULL
	END 
        ),0) AS Wednesday,
        
	-- THURSDAY
    ROUND(AVG(
		CASE
        WHEN DAYNAME(time_of_record) = 'ThurSday' THEN time_in_queue
        ELSE NULL
	END 
        ),0) AS Thursday,
        
	-- FRIDAY
    ROUND(AVG(
		CASE
        WHEN DAYNAME(time_of_record) = 'Friday' THEN time_in_queue
        ELSE NULL
	END 
        ),0) AS Friday,
	
    -- SATURDAY
    ROUND(AVG(
		CASE
        WHEN DAYNAME(time_of_record) = 'Saturday' THEN time_in_queue
        ELSE NULL
	END 
        ),0) AS Saturday 
FROM 
	visits
WHERE 
	time_in_queue <> 0
GROUP BY 
	hour_of_day
ORDER BY 
	hour_of_day;


-- PROJECT TWO QUESTIONS 
SELECT assigned_employee_id, COUNT(visit_count) FROM visits GROUP BY assigned_employee_id ORDER BY COUNT(visit_count) ASC LIMIT 3;
SELECT employee_name,phone_number,email FROM employee WHERE assigned_employee_id IN (20, 22, 44);

SELECT LENGTH(address) FROM employee WHERE employee_name = 'Farai Nia';
SELECT *, LENGTH(TRIM('33 Angelique Kidjo Avenue  ')) FROM employee WHERE employee_name = 'Farai Nia';

SELECT * FROM employee;
SELECT COUNT(employee_name) FROM employee WHERE town_name = 'Dahabu';
SELECT province_name, town_name, COUNT(employee_name) AS living_in_area FROM employee GROUP BY town_name, province_name HAVING province_name = 'Kilimani';

SELECT type_of_water_source, ROUND(AVG(number_of_people_served),0) AS avg_of_people_served_per_source FROM water_source GROUP BY type_of_water_source;

    