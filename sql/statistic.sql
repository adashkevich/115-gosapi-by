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

--- SELECT COUNT OF REPORTED PROBLEMS GROUPED BY DAY OF WEEK  (0 - 6; Sunday is 0)
SELECT COUNT(*), EXTRACT(DOW FROM crm_create_at) AS day FROM problems GROUP BY day ORDER day;

--SELECT WHOLE COUNT OF PROBLEMS BY ORGANIZATION
SELECT COUNT(*), o.name FROM problems AS p JOIN organizations AS o ON o.id=p.organisation_id::int GROUP BY o.name ORDER BY COUNT(*) DESC;
--SELECT COUNT OF UNSOLVED PROBLEMS BY ORGANIZATION
SELECT COUNT(*), o.name FROM problems AS p JOIN organizations AS o ON o.id=p.organisation_id::int WHERE p.status!='5' GROUP BY o.name ORDER BY COUNT(*) DESC;
--SELECT COUNT OF SOLVED PROBLEMS BY ORGANIZATION
SELECT COUNT(*), o.name FROM problems AS p JOIN organizations AS o ON o.id=p.organisation_id::int WHERE p.status='5' GROUP BY o.name ORDER BY COUNT(*) DESC;
--SELECT COUNT OF PROBLEMS BY CATEGORY
SELECT COUNT(*), c.id, c.title, cp.title FROM problems AS p INNER JOIN categories AS c ON c.id = p.category_id INNER JOIN categories AS cp ON cp.id=NULLIF(c.parent_id, '')::int GROUP BY p.category_id, c.id, c.title, cp.title ORDER BY COUNT(*) DESC LIMIT 15;
--SELECT COUNT OF UNSOLVED PROBLEMS BY CATEGORY
SELECT COUNT(*), c.id, c.title, cp.title FROM problems AS p INNER JOIN categories AS c ON c.id = p.category_id INNER JOIN categories AS cp ON cp.id=NULLIF(c.parent_id, '')::int WHERE p.status!='5' GROUP BY p.category_id, c.id, c.title, cp.title ORDER BY COUNT(*) DESC  LIMIT 15;
--SELECT WHOLE COUNT OF PROBLEMS BY DAY
SELECT COUNT(*), crm_create_at FROM problems GROUP BY crm_create_at ORDER BY crm_create_at;