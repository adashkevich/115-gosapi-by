--- SELECT USERS WITH COUNT OF REPORTED PROBLEMS
SELECT u.last_name, u.name, r.problem_count FROM users AS u
  INNER JOIN (SELECT COUNT(problems.id) AS problem_count, problems.user_id FROM problems GROUP BY user_id) AS r
    ON u.id = r.user_id ORDER BY r.problem_count DESC

--- SELECT COUNT OF USERS REPORTED ABOUT AT LEAST ONE PROBLEM
SELECT COUNT(*) FROM users AS u WHERE u.id IN (SELECT DISTINCT p.user_id FROM problems AS p)

--- SELECT COUNT OF PROBLEM GROUP BY DATE AND STATUS
SELECT COUNT(*), status, crm_create_at FROM problems GROUP BY status, crm_create_at ORDER BY crm_create_at, status

--- SELECT PROBLEM COUNT
SELECT COUNT(*) FROM problems