#standardSQL
# 21_11c: Distribution of # of warnings for the Lighthouse 'Preload key requests' audit
SELECT
    ARRAY_LENGTH(JSON_EXTRACT_ARRAY(report, '$.audits.uses-rel-preload.warnings')) warnings,
    COUNT(0) AS freq,
    SUM(COUNT(0)) OVER () AS total,
    ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (), 2) AS pct
FROM
    `httparchive.almanac.summary_pages`
JOIN
  `httparchive.almanac.lighthouse`
USING
(url)
GROUP BY
  warnings
ORDER BY
  warnings ASC