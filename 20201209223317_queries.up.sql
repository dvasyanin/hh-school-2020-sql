SELECT
    hv.position_name,
    ha.city,
    he.name,
    hv.created_at
FROM hh.vacancy AS hv
LEFT JOIN hh.area AS ha on hv.area_id = ha.id
LEFT JOIN hh.employer AS he on hv.employer_id = he.id
WHERE
    hv.compensation_to IS NULL
    AND hv.compensation_from IS NULL
ORDER BY hv.created_at DESC
LIMIT 10;
---------------------------------------------------------
SELECT
    AVG(CASE
            WHEN compensation_gross
            THEN compensation_to / 0.87
            ELSE compensation_to
        END) AS avg_compensation_max,
    AVG(CASE
            WHEN compensation_gross
            THEN compensation_from / 0.87
            ELSE compensation_from
        END) AS avg_compensation_min,
    AVG(CASE
            WHEN compensation_gross
            THEN compensation_to / 0.87
            ELSE compensation_to
        END - CASE
                  WHEN compensation_gross
                  THEN compensation_from / 0.87
                  ELSE compensation_from
              END) AS avg_compensation_mid
FROM hh.vacancy;
---------------------------------------------------------
SELECT
    he.name,
    hv.position_name,
    count(hr) AS count
FROM hh.employer AS he
LEFT JOIN hh.vacancy AS hv on he.id = hv.employer_id
LEFT JOIN hh.response AS hr ON hv.id = hr.vacancy_id
GROUP BY he.name, hv.id
ORDER BY count DESC, name
LIMIT 5;
---------------------------------------------------------
SELECT
    percentile_cont(0.5) WITHIN GROUP (ORDER BY res.count)
FROM (SELECT
          count(*) AS count
      FROM hh.employer AS he
      LEFT JOIN hh.vacancy AS hv ON he.id = hv.employer_id
      GROUP BY he.id) AS res;
---------------------------------------------------------
WITH calculate_query AS (
    SELECT
        hv.id,
        hv.area_id,
        min(hr.created_at - hv.created_at) AS difference_time
    FROM hh.vacancy AS hv
    INNER JOIN hh.response AS hr ON hv.id = hr.vacancy_id
    INNER JOIN hh.employer AS he ON hv.employer_id = he.id
    GROUP BY hv.id, hv.area_id
)
SELECT
    cq.area_id,
    ha.city,
    min(cq.difference_time),
    max(cq.difference_time)
FROM calculate_query AS cq
LEFT JOIN hh.area AS ha ON cq.area_id = ha.id
GROUP BY cq.area_id, ha.city;
