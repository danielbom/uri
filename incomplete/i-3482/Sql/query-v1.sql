create view followers_posts_view as (
	select u1.user_id as u1_id, u1.user_name as u1_name, u1.posts as u1_posts
		, u2.user_id as u2_id, u2.user_name as u2_name, u2.posts as u2_posts
	from followers f
	left join users u1 on (u1.user_id = f.user_id_fk)
	left join users u2 on (u2.user_id = f.following_user_id_fk)
);

select f.u1_id as id, f.u1_name, f.u1_posts, f.u2_name, f.u2_posts
from followers_posts_view f
where f.u1_posts <= f.u2_posts
union
select f.u2_id as id, f.u2_name, f.u2_posts, f.u1_name, f.u1_posts
from followers_posts_view f
where f.u1_posts > f.u2_posts
order by id;
