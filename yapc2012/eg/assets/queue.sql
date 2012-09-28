DROP TABLE IF EXISTS neko_queue;
CREATE TABLE neko_queue (
    id bigint(20) not null,
    user_id int(10) not null,
    is_dis_like tinyint (4) not null,
    published_on int(10) not null
) ENGINE=QUEUE DEFAULT CHARSET=utf8;
