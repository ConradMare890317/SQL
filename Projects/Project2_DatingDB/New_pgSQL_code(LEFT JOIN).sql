SELECT  first_name, last_name, prof.profession, post.suburb, post.city, post.province, post.postal_code, status.status, int.interest, seeking.seeking
FROM my_contacts AS con

LEFT JOIN profession AS prof
ON con.prof_id = prof.prof_id

LEFT JOIN postal_code AS post
ON con.postal_id = post.postal_id

LEFT JOIN status
ON con.status_id = status.status_id


LEFT JOIN seeking_my_contacts AS seek_con
ON con.contact_id = seek_con.my_contacts_contact_id

LEFT JOIN seeking
ON seek_con.seeking_seeking_id = seeking.seeking_id

LEFT JOIN my_contacts_interests AS int_con
ON con.contact_id = int_con.my_contacts_contact_id

LEFT JOIN interests AS int
ON int_con.interests_interest_id = int.interest_id