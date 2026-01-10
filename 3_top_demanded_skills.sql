SELECT
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
GROUP BY
    s.skills
ORDER BY
    "Demand" DESC
LIMIT 5;