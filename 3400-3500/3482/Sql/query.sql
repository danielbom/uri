SELECT u1.user_name AS u1_name, u2.user_name AS u2_name
FROM followers f
JOIN followers each ON each.following_user_id_fk = f.user_id_fk AND each.user_id_fk = f.following_user_id_fk
JOIN users u1 ON u1.user_id = f.user_id_fk
JOIN users u2 ON u2.user_id = f.following_user_id_fk
WHERE u1.posts < u2.posts
ORDER BY u1.user_id;
