alter table accreditation add column requester_company_Id uuid;
alter table accreditation add column request_time timestamp without time zone;
alter table accreditation add column update_time timestamp without time zone;
alter table accreditation add constraint fk_requester_company_id foreign key (requester_company_Id) references company (id) on delete cascade;