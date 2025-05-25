-- USE md_water_services;
/*
CREATE VIEW combined_analysis_table AS
	SELECT
		location.province_name,
		location.town_name,
		location.location_type,
		water_source.type_of_water_source,
		water_source.number_of_people_served,
		visits.time_in_queue,
		well_pollution.results
	FROM
		visits
	JOIN
		location
			ON location.location_id = visits.location_id
	JOIN 
		water_source
			ON water_source.source_id = visits.source_id
	LEFT JOIN
		well_pollution
			ON well_pollution.source_id = visits.source_id
	WHERE 
			visits.visit_count = 1;
*/

/*
WITH province_totals AS (
	SELECT
		province_name,
		SUM(number_of_people_served ) AS total_ppl_serv
	FROM
		combined_analysis_table
	GROUP BY
		province_name
	)

SELECT
	ct.province_name,
	ROUND(
			(SUM(CASE WHEN type_of_water_source = 'river' THEN number_of_people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv), 0) AS river,
	ROUND(
			(SUM(CASE WHEN type_of_water_source = 'shared_tap'THEN number_of_people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv), 0) AS shared_tap,
	
	ROUND(
			(SUM(CASE WHEN type_of_water_source = 'tap_in_home'	THEN number_of_people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv), 0) AS tap_in_home,

	ROUND(
			(SUM(CASE WHEN type_of_water_source = 'tap_in_home_broken'	THEN number_of_people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv), 0) AS tap_in_home_broken,

	ROUND(
			(SUM(CASE WHEN type_of_water_source = 'well'	THEN number_of_people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv), 0) AS well

FROM
combined_analysis_table ct
JOIN
province_totals pt ON ct.province_name = pt.province_name
GROUP BY
ct.province_name
ORDER BY
ct.province_name;
*/

/*
-- CREATE TEMPORARY TABLE town_aggregated_water_access
	WITH town_totals AS (
		SELECT 
		province_name, 
		town_name, 
		SUM(number_of_people_served) AS total_ppl_serv
		FROM 
		combined_analysis_table
		GROUP BY 
		province_name,town_name
	)

	SELECT
	ct.province_name,
	ct.town_name,
		ROUND(
				(SUM(CASE WHEN type_of_water_source = 'river' THEN number_of_people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv), 0) AS river,
		ROUND(
				(SUM(CASE WHEN type_of_water_source = 'shared_tap'THEN number_of_people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv), 0) AS shared_tap,
		
		ROUND(
				(SUM(CASE WHEN type_of_water_source = 'tap_in_home'	THEN number_of_people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv), 0) AS tap_in_home,

		ROUND(
				(SUM(CASE WHEN type_of_water_source = 'tap_in_home_broken'	THEN number_of_people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv), 0) AS tap_in_home_broken,

		ROUND(
				(SUM(CASE WHEN type_of_water_source = 'well'	THEN number_of_people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv), 0) AS well

	FROM
	combined_analysis_table ct
	JOIN 
	town_totals tt ON ct.province_name = tt.province_name AND ct.town_name = tt.town_name
	GROUP BY 
	ct.province_name,
	ct.town_name
	ORDER BY
	ct.town_name;
  
/*  
SELECT * FROM town_aggregated_water_access ORDER BY province_name ASC;
SELECT
province_name,
town_name,
ROUND(tap_in_home_broken / (tap_in_home_broken + tap_in_home) * 100,0) AS Pct_broken_taps
FROM
town_aggregated_water_access
HAVING
Pct_broken_taps > 50
ORDER BY 
province_name
  


SELECT
location.address,
location.town_name,
location.province_name,
water_source.source_id,
water_source.type_of_water_source,
well_pollution.results
FROM
water_source
LEFT JOIN
well_pollution 
	ON water_source.source_id = well_pollution.source_id
INNER JOIN
visits 
	ON water_source.source_id = visits.source_id
INNER JOIN
location 
	ON location.location_id = visits.location_id
WHERE 
visits.visit_count = 1 
AND (results <> 'Clean' 
OR type_of_water_source IN ('river', 'tap_in_home_broken')
OR (type_of_water_source = 'shared_tap' AND time_in_queue > 30)
    );

*/
SELECT 
*
FROM
	(SELECT
		results,
        
        CASE
			WHEN results  ='Contaminated: Biological' THEN 'Install UV'
			ELSE NULL
			END AS Improvement
            FROM
			well_pollution)
project_progress; 

