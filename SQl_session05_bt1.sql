create database session05_bvn2;
use session05_bvn2;
create table users(
id int primary key auto_increment,
fullName varchar(100) not null,
userName varchar(100) not null unique,
passwords varchar(100) not null,
address text,
phone varchar(11),
statuss bit default 1
);
create table roles(
id int primary key auto_increment,
name varchar(100) not null
);
create table user_role(
user_id int,
foreign key(user_id) references users(id),
role_id int,
foreign key(role_id) references roles(id),
primary key(user_id,role_id)
);
INSERT INTO `session05_bvn2`.`user_role` (`user_id`, `role_id`) VALUES ('1', '5');
INSERT INTO `session05_bvn2`.`user_role` (`user_id`, `role_id`) VALUES ('2', '4');
INSERT INTO `session05_bvn2`.`user_role` (`user_id`, `role_id`) VALUES ('5', '3');
INSERT INTO `session05_bvn2`.`user_role` (`user_id`, `role_id`) VALUES ('6', '2');

-- 	Tạo store procedure chức năng đăng ký
DELIMITER //
create procedure INPUT_USER(fullName varchar(100),userName varchar(100),passwords varchar(100),address text,phone varchar(11))
begin 
insert into users(fullName,userName,passwords,address,phone) value(fullName,userName,passwords,address,phone);
end;
//
DELIMITER ;
call INPUT_USER('THU HIEN','thuhienhhpt','kieuvy','PHU THO','0976860174');
call INPUT_USER('QUYNH HOA', 'quynhhoa001', 'quynhhoa', 'HA NOI', '09066201307');
call INPUT_USER('HONG HA', 'hongha002', 'hong ha', 'HA NOI', '09066201307');
INSERT INTO `session05_bvn2`.`users` (`fullName`, `userName`, `passwords`, `address`, `phone`, `statuss`) VALUES ('NAME6', 'userName6', 'pass6', 'THANH HOA', '09066201307', b'0');
-- 	Tạo store procedure chức năng đăng nhập
DELIMITER //
create procedure SIGN_UP_USER(IN userName varchar(100),passwords varchar(100))
begin 
select u.fullName,u.address,u.phone,rl.name from users u
join user_role r
on u.id = r.role_id
join roles rl
on rl.id =r.role_id
where u.userName = userName and u.passwords = passwords;
end;
//
DELIMITER ;
call SIGN_UP_USER('quynhhoa001','quynhhoa');
call SIGN_UP_USER('quynhhoa002','quynhhoa');
-- 	Tạo store procedure chức năng lấy về tất cả user có role là người dùng
DELIMITER //
create procedure USER_3()
begin 
select u.fullName,u.address,u.phone,rl.name from users u
join user_role r
on u.id = r.role_id
join roles rl
on rl.id =r.role_id
where rl.name = 'usser' ;
end;
//
DELIMITER ;
call USER_3();