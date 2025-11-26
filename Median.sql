CREATE TABLE median AS
WITH ranked AS (
    SELECT
        disc_word,
        iq,
        faxtor,
        gtq,
        pauli,
        tiki,
        ROW_NUMBER() OVER (PARTITION BY disc_word ORDER BY iq) AS rn_iq,
        ROW_NUMBER() OVER (PARTITION BY disc_word ORDER BY faxtor) AS rn_faxtor,
        ROW_NUMBER() OVER (PARTITION BY disc_word ORDER BY gtq) AS rn_gtq,
        ROW_NUMBER() OVER (PARTITION BY disc_word ORDER BY pauli) AS rn_pauli,
        ROW_NUMBER() OVER (PARTITION BY disc_word ORDER BY tiki) AS rn_tiki,
        COUNT(*) OVER (PARTITION BY disc_word) AS cnt
    FROM talent_benchmark
),
benchmarks_baseline AS (
    SELECT
        disc_word,
        ROUND(AVG(iq)) AS median_iq,
        ROUND(AVG(faxtor)) AS median_faxtor,
        ROUND(AVG(gtq)) AS median_gtq,
        ROUND(AVG(pauli)) AS median_pauli,
        ROUND(AVG(tiki)) AS median_tiki
    FROM ranked
    WHERE rn_iq IN (cnt/2, cnt/2+1)
       OR rn_faxtor IN (cnt/2, cnt/2+1)
       OR rn_gtq IN (cnt/2, cnt/2+1)
       OR rn_pauli IN (cnt/2, cnt/2+1)
       OR rn_tiki IN (cnt/2, cnt/2+1)
    GROUP BY disc_word
)
SELECT * FROM benchmarks_baseline;

SELECT * FROM median;

DROP TABLE median;


