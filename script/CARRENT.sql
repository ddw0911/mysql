create table rentcompany(
rentcompany_id int unsigned not null comment '캠핑카대여회사 ID',
company_name varchar(30) not null comment '캠핑카대여회사 이름',
address varchar(50) not null comment '캠핑카대여회사 주소',
contact_number varchar(25) not null comment '캠핑카대여회사 연락처',
incharger_name varchar(25) not null comment '캠핑카대여회사 담당자이름',
incharger_email varchar(40) not null comment '캠핑카대여회사 담당자이메일',
primary key (rentcompany_id)
);

create table campingcar(
register_car_id int unsigned not null comment '캠핑카등록 ID',
rentcompany_id int unsigned not null comment '캠핑카대여회사 ID',
campingcar_name varchar(50) not null comment '캠핑카 이름',
campingcar_number varchar(20) not null comment '캠핑카 차량번호',
campingcar_seatcapa int unsigned not null comment '캠핑카 승차인원',
campingcar_image varchar(255) comment '캠핑카 이미지',
campingcar_detailinfo varchar(255) comment '캠핑카 상세정보',
campingcar_rentfee int unsigned not null comment '캠핑카 대여비용',
campingcar_registered_date date not null comment '캠핑카 등록일자',
primary key (register_car_id, rentcompany_id)
);
alter table campingcar add constraint campingcar_fk foreign key (rentcompany_id) references rentcompany(rentcompany_id);

create table repairshop(
repairshop_id int unsigned not null comment '정비소 ID',
repairshop_name varchar(30) not null comment '정비소 이름',
address varchar(50) not null comment '정비소 주소',
contact_number varchar(25) not null comment '정비소 연락처',
incharger_name varchar(25) not null comment '정비소 담당자이름',
incharger_email varchar(40) not null comment '정비소 담당자이메일',
primary key (repairshop_id)
);

create table customer(
driver_license varchar(30) not null comment '운전면허증',
customer_name varchar(30) not null comment '고객 이름',
customer_address varchar(50) not null comment '고객 주소',
customer_contact_number varchar(25) not null comment '고객 연락처',
customer_email varchar(40) comment '고객 이메일',
previous_usedate date comment '이전 캠핑카 사용날짜',
previous_usecartype varchar(40) comment '이전 캠핑카 사용날짜',
primary key (driver_license)
);

create table repair_info(
repair_id int unsigned not null auto_increment comment '정비번호',
register_car_id int unsigned not null comment '캠핑카등록 ID',
repairshop_id int unsigned not null comment '정비소 ID',
rentcompany_id int unsigned not null comment '캠핑카대여회사 ID',
driver_license varchar(30) not null comment '운전면허증',
repair_detail varchar(100) comment '정비내역',
repair_date date not null comment '수리날짜',
repair_fee int unsigned comment '수리비용',
repairfee_duedate date comment '납입기한',
extra_repair varchar(100) comment '기타정비내역',
primary key (repair_id)
);

alter table repair_info add constraint repair_f1 foreign key (register_car_id) references campingcar(register_car_id);
alter table repair_info add constraint repair_f2 foreign key (repairshop_id) references repairshop(repairshop_id);
alter table repair_info add constraint repair_f3 foreign key (rentcompany_id) references rentcompany(rentcompany_id);
alter table repair_info add constraint repair_f4 foreign key (driver_license) references customer(driver_license);

create table rent_campingcar(
rent_id int unsigned not null auto_increment comment '대여번호',
register_car_id int unsigned not null comment '캠핑카등록 ID',
driver_license varchar(30) not null comment '운전면허증',
rentcompany_id int unsigned not null comment '캠핑카대여회사 ID',
rent_startdate date not null comment '대여시작일',
rent_period int unsigned not null comment '대여기간',
rent_fee int unsigned not null comment '청구요금',
rentfee_duedate date not null comment '납입기한',
extra_claimdetail varchar(50) comment '기타청구내역',
extra_charge int unsigned comment '기타청구요금',
primary key (rent_id)
);

alter table rent_campingcar add constraint rent_campingcar_f1 foreign key (register_car_id) references campingcar(register_car_id);
alter table rent_campingcar add constraint rent_campingcar_f2 foreign key (driver_license) references customer(driver_license);
alter table rent_campingcar add constraint rent_campingcar_f3 foreign key (rentcompany_id) references rentcompany(rentcompany_id);

commit;