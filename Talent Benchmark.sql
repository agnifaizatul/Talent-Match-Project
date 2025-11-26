CREATE TABLE talent_benchmark AS
SELECT 
    e.position_id AS job_vacancy_id,
    dp.name AS role_name,
    e.grade_id AS job_level,
    d.meaning AS role_purpose,
    e.employee_id AS selected_talent_ids,
    pp.disc_word,
    pp.iq,
    pp.faxtor,
    pp.gtq,
    pp.pauli,
    pp.tiki,
    pp.mbti
FROM employees e
JOIN dim_positions dp ON e.position_id = dp.position_id
JOIN performance_yearly py ON e.employee_id = py.employee_id
JOIN disc d ON pp.disc = d.disc
LEFT JOIN profiles_psych pp ON e.employee_id = pp.employee_id
WHERE py.rating = 5;

SELECT * FROM talent_benchmark;

DROP TABLE talent_benchmark; 


