SELECT hv.position_name,
       ha.city,
       he.name,
       hv.created_at
FROM hh.vacancy hv
         LEFT JOIN hh.area ha on hv.area_id = ha.id
         LEFT JOIN hh.employer he on hv.employer_id = he.id
WHERE hv.compensation_to IS NULL
  AND hv.compensation_from IS NULL
ORDER BY hv.created_at DESC
LIMIT 10;
---------------------------------------------------------
SELECT AVG(compensation_to / (CASE
                                  WHEN compensation_gross
                                      THEN 0.87
                                  ELSE 1
    END)):: BIGINT        AS avg_compensation_max,
       AVG(compensation_from / (CASE
                                    WHEN compensation_gross
                                        THEN 0.87
                                    ELSE 1
           END)):: BIGINT AS avg_compensation_min,
       AVG(compensation_to / (CASE
                                  WHEN compensation_gross
                                      THEN 0.87
                                  ELSE 1
           END):: BIGINT - compensation_from / (CASE
                                                    WHEN compensation_gross
                                                        THEN 0.87
                                                    ELSE 1
           END):: BIGINT) AS avg_compensation_mid
FROM hh.vacancy;
---------------------------------------------------------
SELECT he.name, hv.position_name, count(hr) AS count
FROM hh.vacancy hv
         LEFT JOIN hh.response hr ON hv.id = hr.vacancy_id
         LEFT JOIN hh.employer he ON hv.employer_id = he.id
GROUP BY he.name, hv.id
ORDER BY count DESC, name
LIMIT 5;
---------------------------------------------------------
SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY res.count)
FROM (SELECT count(*) AS count
      FROM hh.employer he
                LEFT JOIN hh.vacancy hv ON he.id = hv.employer_id
      GROUP BY he.name) AS res;
---------------------------------------------------------
SELECT result.city, min(result.difference) AS min_response, max(result.difference) AS max_response
FROM (SELECT ha.city, hv.created_at, hr.created_at, (hr.created_at - hv.created_at) AS difference
      FROM hh.response hr
               LEFT JOIN hh.vacancy hv ON hr.vacancy_id = hv.id
               LEFT JOIN hh.area ha ON hv.area_id = ha.id) AS result
GROUP BY result.city;