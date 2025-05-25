USE md_water_services;

/*SELECT * FROM auditor_report;

SELECT location_id, true_water_source_score FROM auditor_report;

SELECT 
	auditor_report.location_id AS audit_location, 
	auditor_report.true_water_source_score AS visit_location,
	visits.location_id,
	visits.record_id
FROM auditor_report
JOIN visits 
		ON auditor_report.location_id = visits.location_id;


SELECT 
	auditor_report.location_id AS audit_location, 
    auditor_report.true_water_source_score AS auditor_score, 
	visits.record_id,
    water_quality.subjective_quality_score AS surveyor_score
FROM auditor_report
JOIN visits 
		ON auditor_report.location_id = visits.location_id
JOIN water_quality
		ON water_quality.record_id = visits.record_id
WHERE auditor_report.true_water_source_score != water_quality.subjective_quality_score
		AND visits.visit_count = 1;
     

SELECT 
	auditor_report.location_id AS audit_location, 
    auditor_report.true_water_source_score AS auditor_score, 
	visits.record_id,
    water_quality.subjective_quality_score AS surveyor_score,
    water_source.type_of_water_source AS surveyor_source,
    auditor_report.type_of_water_source AS auditor_source
FROM auditor_report
JOIN visits 
		ON auditor_report.location_id = visits.location_id
JOIN water_quality
		ON water_quality.record_id = visits.record_id
JOIN water_source
		ON water_source.source_id = visits.source_id
WHERE auditor_report.true_water_source_score != water_quality.subjective_quality_score
		AND visits.visit_count = 1;
 

WITH Incorrect_records AS(
	SELECT 
		auditor_report.location_id AS audit_location, 
		visits.record_id,
		employee.employee_name,
		auditor_report.true_water_source_score AS auditor_score,
		water_quality.subjective_quality_score AS surveyor_score
	FROM auditor_report
	JOIN visits 
			ON auditor_report.location_id = visits.location_id
	JOIN water_quality
			ON water_quality.record_id = visits.record_id
	JOIN employee
			ON  employee.assigned_employee_id = visits.assigned_employee_id
	WHERE auditor_report.true_water_source_score != water_quality.subjective_quality_score
			AND visits.visit_count = 1
)
SELECT * FROM Incorrect_records;


WITH Incorrect_records AS(
	SELECT 
		auditor_report.location_id AS audit_location, 
		visits.record_id,
		employee.employee_name,
		auditor_report.true_water_source_score AS auditor_score,
		water_quality.subjective_quality_score AS surveyor_score
	FROM auditor_report
	JOIN visits 
			ON auditor_report.location_id = visits.location_id
	JOIN water_quality
			ON water_quality.record_id = visits.record_id
	JOIN employee
			ON  employee.assigned_employee_id = visits.assigned_employee_id
	WHERE auditor_report.true_water_source_score != water_quality.subjective_quality_score
			AND visits.visit_count = 1
)
SELECT 
	DISTINCT employee_name,
    COUNT(employee_name) AS number_of_mistakes
FROM 
	Incorrect_records
GROUP BY
	employee_name;


WITH 
	Incorrect_records AS(
		SELECT 
			auditor_report.location_id AS audit_location, 
			visits.record_id,
			employee.employee_name,
			auditor_report.true_water_source_score AS auditor_score,
			water_quality.subjective_quality_score AS surveyor_score
		FROM auditor_report
		JOIN visits 
				ON auditor_report.location_id = visits.location_id
		JOIN water_quality
				ON water_quality.record_id = visits.record_id
		JOIN employee
				ON  employee.assigned_employee_id = visits.assigned_employee_id
		WHERE auditor_report.true_water_source_score != water_quality.subjective_quality_score
				AND visits.visit_count = 1
	),

	error_count AS(
		SELECT 
			DISTINCT employee_name,
			COUNT(employee_name) AS number_of_mistakes
		FROM 
			Incorrect_records
		GROUP BY
			employee_name
		)	
SELECT
	AVG(number_of_mistakes) AS avg_error_count_per_empl
FROM
	error_count;
*/

/*CREATE VIEW 
	Incorrect_records AS (
	SELECT
		auditor_report.location_id,
		visits.record_id,
		employee.employee_name,
		auditor_report.true_water_source_score AS auditor_score,
		wq.subjective_quality_score AS surveyor_score,
		auditor_report.statements AS statements
	FROM auditor_report
	JOIN visits
		ON auditor_report.location_id = visits.location_id
	JOIN water_quality AS wq
		ON visits.record_id = wq.record_id
	JOIN employee
		ON employee.assigned_employee_id = visits.assigned_employee_id
	WHERE
		visits.visit_count =1
	AND 
		auditor_report.true_water_source_score != wq.subjective_quality_score);


SELECT * FROM Incorrect_records;

WITH 
	error_count AS(
			SELECT 
				DISTINCT employee_name,
				COUNT(employee_name) AS number_of_mistakes
			FROM 
				Incorrect_records
			GROUP BY
				employee_name
			),	
	suspect_list AS (
			SELECT
				employee_name,
				number_of_mistakes
			FROM
				error_count	
			WHERE
				number_of_mistakes > (
					SELECT 
						AVG (number_of_mistakes) 
					FROM 
						error_count
                        ) )
			
SELECT
	employee_name,
	location_id,
	statements
FROM
	Incorrect_records
WHERE
	 employee_name not in (
		SELECT
			employee_name
		FROM 
			suspect_list
            );
*/
