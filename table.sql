create table users (
    id uuid default gen_random_uuid(),
    username varchar not null,
    email varchar not null,
    status int not null default 0,
    password varchar not null,
    name varchar not null,
    photo varchar not null default '',
    cover varchar not null default '',
    theme varchar not null default '',
    location varchar not null default '',
    bio varchar not null default '',
    birth_date_d int,
    birth_date_m int,
    birth_date_y int,
    show_dm boolean not null default false,
    show_y boolean not null default false,
    created_at timestamp not null default now(),
    updated_at timestamp not null default now(),
    primary key (id)
);
create unique index on users (username);
create unique index on users (email);

create table follows (
    follower_id int,
    following_id int,
    created_at timestamp not null default now(),
    primary key (follower_id, following_id),
    foreign key (follower_id) references users (id),
    foreign key (following_id) references users (id)
);
create index on follows (follower_id, created_at desc);
create index on follows (following_id, created_at desc);

create table tweets (
    id uuid default gen_random_uuid(),
    user_id uuid not null,
    content varchar not null,
    photos varchar[],
    type int not null,
    created_at timestamp not null default now(),
    primary key (id),
    foreign key (user_id) references users (id)
);
create index on tweets (created_at desc);
create index on tweets (user_id, created_at desc);

create table hashtags (
    name varchar,
    created_at timestamp not null default now(),
    primary key (name)
);
create index on hashtags (created_at desc);

create table tweet_hashtags (
    tweet_id uuid,
    hashtag varchar,
    primary key (tweet_id, hashtag),
    foreign key (tweet_id) references tweets (id),
    foreign key (hashtag) references hashtags (name)
);

create table polls (
    tweet_id uuid,
    end_time timestamp not null,
    primary key (tweet_id),
    foreign key (tweet_id) references tweets (id)
);

create table choices (
    id uuid default gen_random_uuid(),
    tweet_id uuid not null,
    content varchar,
    primary key (id),
    foreign key (tweet_id) references polls (tweet_id)
);

create table votes (
    user_id uuid,
    tweet_id uuid,
    choice_id uuid,
    created_at timestamp not null default now(),
    primary key (user_id, tweet_id),
    foreign key (user_id) references users (id),
    foreign key (tweet_id) references tweets (id),
    foreign key (choice_id) references choices (id)
);

create table tweet_likes (
    user_id uuid,
    tweet_id uuid,
    created_at timestamp not null default now(),
    primary key (user_id, tweet_id),
    foreign key (user_id) references users (id),
    foreign key (tweet_id) references tweets (id)
);
create index on tweet_likes (user_id, created_at desc);
create index on tweet_likes (tweet_id, created_at desc);

create table retweets (
    user_id uuid,
    tweet_id uuid,
    content varchar not null default '',
    created_at timestamp not null default now(),
    primary key (user_id, tweet_id),
    foreign key (user_id) references users (id),
    foreign key (tweet_id) references tweets (id)
);
create index on retweets (user_id, created_at desc);
create index on retweets (tweet_id, created_at desc);

create table replies (
    id uuid default gen_random_uuid(),
    tweet_id uuid not null,
    user_id uuid not null,
    content varchar not null,
    created_at timestamp not null default now(),
    primary key (id),
    foreign key (tweet_id) references tweets (id),
    foreign key (user_id) references users (id)
);
create index on replies (tweet_id, created_at desc);

create table chats (
    id uuid default gen_random_uuid(),
    sender_id uuid not null,
    receiver_id uuid not null,
    content varchar not null,
    type int not null,
    created_at timestamp not null default now(),
    primary key (id),
    foreign key (sender_id) references users (id),
    foreign key (receiver_id) references users (id)
);
create index on chats (sender_id, receiver_id, created_at desc);

create table notifications (
    id uuid default gen_random_uuid(),
    user_id uuid not null,
    title varchar not null,
    content varchar not null,
    photo varchar not null,
    is_read boolean not null default false,
    created_at timestamp not null default now(),
    primary key (id),
    foreign key (user_id) references users (id)
);
create index on notifications (user_id, created_at desc);
create index on notifications (user_id, is_read, created_at desc);
