SELECT *
FROM users AS u1
WHERE u1.gender = 'MALE'
  AND u1.looking_for = 'RELATIONSHIP'
  AND u1.dob + INTERVAL '18 years' <= CURRENT_DATE -- Pass the user that searches min_age
  AND u1.dob + INTERVAL '26 years' >= CURRENT_DATE -- Pass the user that searches max_age
  AND u1.is_active IS FALSE
  AND u1.is_chatting IS FALSE
  AND EXISTS (
    SELECT 1
    FROM users AS u2
    WHERE u2.gender = u1.gender
      AND u2.looking_for = u1.looking_for
      AND u2.dob <= CURRENT_DATE - (u1.min_age * INTERVAL '1 year') -- Reverse min_age
      AND u2.dob >= CURRENT_DATE - (u1.max_age * INTERVAL '1 year') -- Reverse max_age
  );
