-- View all login attempts
SELECT * FROM login_attempts;

-- Failed login attempts by IP
SELECT ip_address, COUNT(*) AS failed_attempts
FROM login_attempts
WHERE success = false
GROUP BY ip_address
ORDER BY failed_attempts DESC;

-- Potential brute-force detection (3+ failed attempts)
SELECT ip_address, COUNT(*) AS failed_attempts
FROM login_attempts
WHERE success = false
GROUP BY ip_address
HAVING COUNT(*) >= 3
ORDER BY failed_attempts DESC;

-- Failed attempts by username
SELECT username, COUNT(*) AS failed_attempts
FROM login_attempts
WHERE success = false
GROUP BY username
ORDER BY failed_attempts DESC;

-- Suspicious user agents (automation tools)
SELECT *
FROM login_attempts
WHERE user_agent ILIKE '%curl%'
   OR user_agent ILIKE '%python%';

-- Logins during unusual hours (00:00–05:00)
SELECT *
FROM login_attempts
WHERE EXTRACT(HOUR FROM attempt_time) BETWEEN 0 AND 5
ORDER BY attempt_time;
