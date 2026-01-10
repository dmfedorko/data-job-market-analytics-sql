WITH top_demanded_skills AS (
    SELECT
        s.skill_id AS "ID",
        s.skills AS "Skills",
        COUNT(sj.job_id) AS "Demand"
    FROM
        job_postings_fact AS j
    INNER JOIN skills_job_dim AS sj
    ON j.job_id = sj.job_id
    INNER JOIN skills_dim AS s
    ON sj.skill_id = s.skill_id
    WHERE
        j.job_title_short IN ('Data Analyst', 'Business Analyst')
        AND job_work_from_home = true
        AND salary_year_avg IS NOT NULL
    GROUP BY
        s.skill_id, s.skills
),top_paying_skills AS (
    SELECT
        s.skill_id AS "ID",
        s.skills AS "Skills",
        ROUND(AVG(j.salary_year_avg)) AS "Salary"
    FROM
        job_postings_fact AS j
    INNER JOIN skills_job_dim AS sj
    ON j.job_id = sj.job_id
    INNER JOIN skills_dim AS s
    ON sj.skill_id = s.skill_id
    WHERE
        j.job_title_short IN ('Data Analyst', 'Business Analyst')
        AND job_work_from_home = true
        AND salary_year_avg IS NOT NULL
    GROUP BY
        s.skill_id, s.skills)

SELECT
    top_demanded_skills."ID",
    top_demanded_skills."Skills",
    top_demanded_skills."Demand",
    top_paying_skills."Salary"
FROM
    top_demanded_skills
INNER JOIN top_paying_skills 
ON top_demanded_skills."ID" = top_paying_skills."ID"
WHERE
    "Demand" > 20
ORDER BY
    "Salary" DESC, "Demand" DESC
LIMIT 10;