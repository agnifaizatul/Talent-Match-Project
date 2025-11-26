CREATE TABLE final_output AS
SELECT
    e.employee_id,
    dd.name AS directorate,
    dp.name AS role,
    dg.name AS grade,
    d.tgv_name,
    d.disc_word AS tv_name,
    m.median_iq AS baseline_score,
    pp.iq AS user_score,
    ROUND((pp.iq / m.median_iq)*100,2) AS tv_match_rate
FROM employees e
JOIN dim_directorates dd ON e.directorate_id = dd.directorate_id
JOIN dim_positions dp ON e.position_id = dp.position_id
JOIN dim_grades dg ON e.grade_id = dg.grade_id
JOIN disc d ON pp.disc = d.disc
JOIN median m ON pp.disc_word = m.disc_word
LEFT JOIN profiles_psych pp ON e.employee_id = pp.employee_id;

SELECT * FROM final_output;

DROP TABLE final_output; 


