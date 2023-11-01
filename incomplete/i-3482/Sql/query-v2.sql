with ranked_followers as (
  select distinct
  	case when u1.posts <= u2.posts then u1.user_id else u2.user_id end as id,
	case when u1.posts >= u2.posts then u2.user_name else u1.user_name end as u1_name,
	case when u1.posts >= u2.posts then u2.posts else u1.posts end as u1_posts,
	case when u1.posts >= u2.posts then u1.user_name else u2.user_name end as u2_name,
	case when u1.posts >= u2.posts then u1.posts else u2.posts end as u2_posts
	from followers f
	join users u1 on f.user_id_fk = u1.user_id
	join users u2 on f.following_user_id_fk = u2.user_id
)
select u1_name, u2_name
from ranked_followers
order by id;
