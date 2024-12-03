--pass the looking for value of the user that is doing the search in 
SELECT *
FROM users
WHERE gender = 'MALE'
  AND looking_for = 'RELATIONSHIP'
  AND dob + INTERVAL '18 years' <= CURRENT_DATE --pass the user that searches min_age
  AND dob + INTERVAL '26 years' >= CURRENT_DATE -- pass the user that searches max_age
  AND is_active is true
  AND is_chatting is false