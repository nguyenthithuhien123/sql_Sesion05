create database session05_bt2;
use session05_bt2;
create table class(
class_Id int primary key auto_increment,
class_Name varchar(100) not null,
start_Date date default(current_date()),
statuss bit default 1
);
create table student(
student_Id int primary key auto_increment,
student_Name varchar(100) not null,
address text ,
phone varchar(11),
statuss bit default 1,
class_Id int,
foreign key (class_Id) references class(class_Id)
);
create table subjects(
sub_Id int primary key auto_increment,
sub_Name varchar(100) not null,
credit int ,
statuss bit default 1
);
create table mark(
mark_Id int primary key auto_increment,
sub_Id int,
foreign key(sub_Id) references subjects(sub_Id),
student_Id int,
foreign key(student_Id) references student(student_Id),
mark float,
examtime time default(current_time())
);

DELIMITER //
CREATE PROCEDURE INPUT_CLASS (IN class_Name_Input varchar(100))
 BEGIN
	INSERT INTO `session05_bt2`.`class` (`class_Name`) VALUES (class_Name_Input);
END;
//
DELIMITER ;
call session05_bt2.INPUT_CLASS('lớp toán');
call session05_bt2.INPUT_CLASS('lớp lý');
call session05_bt2.INPUT_CLASS('lớp hóa');
call session05_bt2.INPUT_CLASS('lớp sinh');
call session05_bt2.INPUT_CLASS('lớp văn');
select* from class;
DELIMITER //
CREATE PROCEDURE INPUT_STUDENT (IN student_Name varchar(100),address text,phone varchar(11),class_Id int)
 BEGIN
INSERT INTO `session05_bt2`.`student` (`student_Name`, `address`, `phone`, `class_Id`) VALUES (student_Name,address,phone,class_Id);
END;
//
DELIMITER ;
call session05_bt2.INPUT_STUDENT('KIỀU VY', 'PHÚ THỌ', '0976860174',1);
call session05_bt2.INPUT_STUDENT('TƯỜNG VY', 'PHÚ THỌ', '0976860174',1);
call session05_bt2.INPUT_STUDENT('QUỲNH HOA', 'PHÚ THỌ', '0976860174',2);
DELIMITER //
CREATE PROCEDURE INPUT_SUBJECTS (IN sub_Name varchar(100),credit int )
 BEGIN
INSERT INTO `session05_bt2`.`subjects` (`sub_Name`, `credit`) VALUES (sub_Name, credit);
END;
//
DELIMITER ;
call session05_bt2.INPUT_SUBJECTS('LÝ', 10);
call session05_bt2.INPUT_SUBJECTS('HÓA', 10);
call session05_bt2.INPUT_SUBJECTS('SINH', 10);
call session05_bt2.INPUT_SUBJECTS('VĂN', 10);
call session05_bt2.INPUT_SUBJECTS('SỬ', 10);
call session05_bt2.INPUT_SUBJECTS('ĐỊA', 10);
DELIMITER //
CREATE PROCEDURE INPUT_MARK (IN sub_Id int,student_Id int,mark float )
 BEGIN
INSERT INTO `session05_bt2`.`mark` (`sub_Id`, `student_Id`, `mark`)  VALUES (sub_Id, student_Id,mark);
END;
//
DELIMITER ;
call session05_bt2.INPUT_MARK(1, 8, 9.5);
call session05_bt2.INPUT_MARK(3, 9, 6.0);
call session05_bt2.INPUT_MARK(3, 9, 7.2);
call session05_bt2.INPUT_MARK(3, 8, 8.6);
-- HỌC SINH CÓ ĐIỂM CAO NHẤT MÔN HÓA SẮP XẾP GIẢM DẦN
DELIMITER //
CREATE PROCEDURE MAX_HOA()
 BEGIN
SELECT s.student_Name,m.mark as ĐIỂM_MÔN_HÓA from student s
join mark m
on s.student_id=m.student_id
join subjects sb
on sb.sub_Id = m.sub_id
where sb.sub_Name = 'HÓA'
order by m.mark desc ;
END;
//
DELIMITER ;
call MAX_HOA();

DELIMITER //
CREATE PROCEDURE MAX_SUBJECTS()
 BEGIN
SELECT sb.sub_Name, count(m.mark) as số_học_sinh_thi from mark m
join subjects sb
on sb.sub_Id = m.sub_id
group by sb.sub_Name
ORDER BY số_học_sinh_thi DESC ;
END;
//
DELIMITER ;
CALL MAX_SUBJECTS();