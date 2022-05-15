

create table guestboard(
    name varchar2(10),
    email varchar2(50),
    inputdate varchar2(40) primary key,
    subject varchar2(20),
    content varchar2(2000)
);

select * from guestboard;

desc guestboard;

select * from guestboard order by inputdate desc;

commit;

delete guestboard;