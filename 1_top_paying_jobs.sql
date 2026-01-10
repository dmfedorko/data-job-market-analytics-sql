SELECT
    j.job_id AS "ID",
    j.job_title_short AS "Title",
    c.name AS "Company",
    j.job_location AS "Location",
    j.job_schedule_type AS "Schedule",
    ROUND(j.salary_year_avg, 0) AS "Salary",
    j.job_posted_date::DATE AS "Date"
FROM
    job_postings_fact AS j
LEFT JOIN company_dim AS c
ON j.company_id = c.company_id
WHERE
    job_title_short IN ('Data Analyst', 'Business Analyst')
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
