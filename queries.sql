--1.Retrieve all subjects taught by specific teacher (Belirli bir öğretmen tarafından öğretilen tüm dersleri getirme)
select * from Subjects

--2.Find the teachers for a particular subjects (Belirli bir dersin öğretmenlerini bulma)
select T.Teacher_ID,T.T_Fname,T.T_Lname,T.Email,T.Phone,T.D_ID,T.Tutor,S_ID,S.S_Name
from Teachers as T inner join Subjects as S on T.Teacher_ID=S.Teacher_ID

--3.Get the classes assigned to specific tutor (Belirli bir eğitmenin atandığı dersleri getirme)
select T.Tutor_ID,TE.T_Fname,TE.T_Lname,C.Class_ID, C.Class_Name from Tutors T  inner join Teachers TE
on T.Teacher_ID=TE.Teacher_ID inner join Classes C on C.Tutor_ID=T.Tutor_ID

--4.Get a list of all tutors in particular department (Belirli bir departmanda görevli tüm eğitmenleri listeleme)
select T.Teacher_ID, T.T_Fname, T.T_Lname, D.D_ID, D.D_Name from teachers T 
inner join Departments D  on D.D_ID=T.D_ID where  T.Tutor=True

--5.Count the number of classes for each department (Her departman için ders sayısını sayma)
select D.D_Name,count(C.Class_ID) from Classes C inner join Tutors T on C.Tutor_ID=T.Tutor_ID
inner join Teachers TE on T.Teacher_ID=TE.Teacher_ID inner join Departments D on TE.D_ID=D.D_ID GROUP BY D.D_Name

--6.Find all teachers who teach multiple subjects. (Birden fazla ders veren öğretmenleri bulma)
select Teacher_ID,count(Teacher_ID) as "Count of subjects"
from Subjects group by Teacher_ID  having count(Teacher_ID)>1 

--7.Retrieve all subjects along with their respective departments (Tüm dersleri ve bağlı oldukları departmanları getirme)
select S.S_ID,S.S_Name,D.D_ID,D.D_Name from Subjects S inner join Teachers T 
on S.Teacher_ID=T.Teacher_ID inner join Departments D on T.D_ID=D.D_ID

--8.Find the most popular subject (taught in the highest number of classes). (En popüler dersi (en fazla derste öğretilen dersi) bulma)
select count(S_ID), S_ID from TimeTable group by S_ID order by count(S_ID) desc limit 1

--9.Retrieve information about classes along with the corresponding teacher's name(Ders bilgileri ve öğretmen bilgileri)
Select C.Class_ID, C.Class_Name, C.Class_Level,TE.T_Fname, TE.T_Lname from Classes C inner join Tutors T on
C.Tutor_ID=T.Tutor_ID inner join Teachers TE on T.Teacher_ID=TE.Teacher_ID

--10.List all teachers and subjects they teach, including the department information (Tüm öğretmenleri ve verdikleri dersleri, departman bilgisiyle birlikte listeleme)
Select S.S_Name, T.T_Lname || ' ' || T.T_Fname as Teacher , D.D_ID, D.D_Name, D.Teacher_num from Subjects S inner join Teachers T
on S.Teacher_ID=T.Teacher_ID inner join Departments D  on D.D_ID=T.D_ID

--11.Retrieve all classes for specific department and include the teacher's Information (Belirli bir departman için dersler ve öğretmen bilgileri)
Select C.Class_ID, C.Class_Name, C.Class_Level,D.D_ID, D.D_Name,TE.Teacher_ID,TE.T_Fname,TE.T_Lname, TE.Phone, TE.Email, TE.Tutor
from Classes C inner join Tutors T on C.Tutor_ID=T.Tutor_ID
inner join Teachers TE on T.Teacher_ID=TE.Teacher_ID inner join Departments D on TE.D_ID=D.D_ID 

--12. Retrieve all teachers and classes they are assigned to, including teachers without assigned classes (Tüm öğretmenleri ve atandıkları dersleri listeleme, atanmamış öğretmenler dahil)
select TE.T_Lname ||' ' || TE.T_Fname as Teacher, C.Class_Name from Tutors T inner join Teachers TE on T.Teacher_ID=TE.Teacher_ID 
left join Classes C  on C.Tutor_ID=T.Tutor_ID

--13.List all rooms and the classes scheduled in each room including rooms without assigned classes (Tüm odaları ve her odada planlanan dersleri listeleme, atanmamış dersler dahil)
select R.Room_ID, R.Room_Name, R.Capacity , C.Class_ID, C.Class_Name from Classes C inner join TimeTable T on
T.Class_ID=C.Class_ID right join Rooms R on T.Room_ID=R.Room_ID

--14. Get total number of classes taught by each teacher. (Her öğretmenin verdiği toplam ders sayısını getirme)
select count(Class_ID) as "Number_of_Classes", Teacher_ID from Timetable group by Teacher_ID