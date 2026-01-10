WITH top_jobs AS(
    SELECT
        j.job_id AS "ID",
        j.job_title_short AS "Title",
        c.name AS "Company",
        ROUND(j.salary_year_avg, 0) AS "Salary"
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
    LIMIT 10)

SELECT
    t.*,
    s.skills AS "SKills"
FROM
    top_jobs AS t
INNER JOIN skills_job_dim AS sj
ON t."ID" = sj.job_id
INNER JOIN skills_dim AS s
ON sj.skill_id = s.skill_id;
