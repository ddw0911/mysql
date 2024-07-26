create table doctor(
doctor_id int unsigned not null,
incharge_diagnosis varchar(50) not null,
doctor_name varchar(50) not null,
doctor_gender varchar(6) not null,
phone_number varchar(15),
email varchar(30) not null,
position varchar(20) not null,
primary key(doctor_id)
);

create table nurse(
nurse_id int unsigned not null,
incharge_task varchar(50) not null,
nurse_name varchar(50) not null,
number_gender varchar(6) not null,
phone_number varchar(15),
email varchar(30) not null,
position varchar(20) not null,
primary key(nurse_id)
);

create table patients(
patients_id int unsigned not null,
nurse_id int unsigned not null, 
doctor_id int unsigned not null,
patients_name varchar(50) not null,
patients_gender varchar(6) not null,
patient_idnum varchar(20) not null,
address varchar(100) not null,
phone_number varchar(15),
email varchar(30) not null,
job varchar(20),
primary key(patients_id),
foreign key(nurse_id) references nurse(nurse_id),
foreign key(doctor_id) references doctor(doctor_id)
);

create table diagnosis(
diagnosis_id varchar(30) not null,
patients_id int unsigned not null, 
doctor_id int unsigned not null, 
diagnosis_content varchar(100),
diagnosis_date date not null,
foreign key(patients_id) references patients(patients_id),
foreign key(doctor_id) references doctor(doctor_id),
unique key(diagnosis_id , patients_id , doctor_id) 
);

create table chart(
chart_number int unsigned not null auto_increment,
diagnosis_id varchar(30) not null,
doctor_id int unsigned not null,
patients_id int unsigned not null,
nurse_id int unsigned not null,
chart_content varchar(50) not null,
foreign key(diagnosis_id) references diagnosis(diagnosis_id),
foreign key(doctor_id) references doctor(doctor_id),
foreign key(patients_id) references patients(patients_id),
foreign key(nurse_id) references nurse(nurse_id),
unique key(chart_number, diagnosis_id , doctor_id, patients_id)
);

commit;
