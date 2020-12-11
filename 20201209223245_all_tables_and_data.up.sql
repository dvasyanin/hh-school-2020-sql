CREATE SCHEMA hh;

CREATE TABLE hh.area
(
    id         serial primary key,
    created_at timestamptz default now(),
    updated_at timestamptz,
    city       text
);

CREATE TABLE hh.employer
(
    id         serial primary key,
    created_at timestamptz default now(),
    updated_at timestamptz,
    name       text    not null,
    area_id    integer not null references hh.area (id)
);

CREATE TABLE hh.vacancy
(
    id                 serial primary key,
    created_at         timestamptz      default now(),
    updated_at         timestamptz,
    area_id            integer not null references hh.area (id),
    employer_id        integer not null references hh.employer (id),
    position_name      text    not null,
    description        text    not null,
    compensation_from  integer,
    compensation_to    integer,
    compensation_gross boolean not null default false
);

CREATE TABLE hh.applicant
(
    id         serial primary key,
    created_at timestamptz default now(),
    updated_at timestamptz,
    name       text not null
);


CREATE TABLE hh.resume
(
    id                serial primary key,
    created_at        timestamptz default now(),
    updated_at        timestamptz,
    applicant_id      integer not null references hh.applicant (id),
    position_name     text    not null,
    description       text    not null,
    compensation_from integer
);

CREATE TYPE enum_response_status AS ENUM ('denial', 'in_work', 'interview');

CREATE TABLE hh.response
(
    id         serial primary key,
    created_at timestamptz default now(),
    updated_at timestamptz,
    vacancy_id integer not null references hh.vacancy (id),
    resume_id  integer not null references hh.resume (id),
    status     enum_response_status
);

INSERT INTO hh.applicant (name)
VALUES ('Иванов И.И.');
INSERT INTO hh.applicant (name)
VALUES ('Петухов С.А.');
INSERT INTO hh.applicant (name)
VALUES ('Иванова Л.М.');
INSERT INTO hh.applicant (name)
VALUES ('Петухова Е.А.');
INSERT INTO hh.applicant (name)
VALUES ('Unknown User');

INSERT INTO hh.area (city)
VALUES ('Москва');
INSERT INTO hh.area (city)
VALUES ('Санкт-Петербург');
INSERT INTO hh.area (city)
VALUES ('Архангельск');
INSERT INTO hh.area (city)
VALUES ('Кизляр');
INSERT INTO hh.area (city)
VALUES ('Краснодар');
INSERT INTO hh.area (city)
VALUES ('Псков');
INSERT INTO hh.area (city)
VALUES ('Норильск');
INSERT INTO hh.area (city)
VALUES ('Сочи');
INSERT INTO hh.area (city)
VALUES ('Туапсе');

INSERT INTO hh.employer (name, area_id)
VALUES ('hh.ru', 1);
INSERT INTO hh.employer (name, area_id)
VALUES ('Google', 1);
INSERT INTO hh.employer (name, area_id)
VALUES ('Facebook', 1);
INSERT INTO hh.employer (name, area_id)
VALUES ('Рога и Копыта', 4);
INSERT INTO hh.employer (name, area_id)
VALUES ('Microsoft', 2);
INSERT INTO hh.employer (name, area_id)
VALUES ('Яндекс', 2);
INSERT INTO hh.employer (name, area_id)
VALUES ('12Storeez', 3);
INSERT INTO hh.employer (name, area_id)
VALUES ('Руссиатэкс', 5);
INSERT INTO hh.employer (name, area_id)
VALUES ('good-soft', 6);
INSERT INTO hh.employer (name, area_id)
VALUES ('Ростелеком', 7);

INSERT INTO hh.vacancy (area_id, employer_id, position_name, description)
VALUES (1, 1, 'Разработчик', 'Ищем инженера java');
INSERT INTO hh.vacancy (area_id, employer_id, position_name, description, compensation_from, compensation_to,
                        compensation_gross)
VALUES (2, 2, 'Тестировщик', 'Много багов', 100000, 200000, true);
INSERT INTO hh.vacancy (area_id, employer_id, position_name, description)
VALUES (3, 3, 'Аналитик', 'Какое-то описание');
INSERT INTO hh.vacancy (area_id, employer_id, position_name, description, compensation_from, compensation_to,
                        compensation_gross)
VALUES (4, 4, 'Бухгалтер', 'Какое-то описание', 15000, 20000, true);
INSERT INTO hh.vacancy (area_id, employer_id, position_name, description, compensation_from, compensation_to,
                        compensation_gross)
VALUES (5, 5, 'Посудомойщик', 'Нужен опрятный, аккуратный, без вредных привычек посудомойщик', 13, 15, false);
INSERT INTO hh.vacancy (area_id, employer_id, position_name, description)
VALUES (1, 1, 'Разработчик java', 'Какое-то хорошее описание вакансии');
INSERT INTO hh.vacancy (area_id, employer_id, position_name, description, compensation_from, compensation_to,
                        compensation_gross)
VALUES (2, 2, 'Разработчик go', 'Какое-то хорошее описание вакансии', 220000, 250000, true);
INSERT INTO hh.vacancy (area_id, employer_id, position_name, description, compensation_from, compensation_to,
                        compensation_gross)
VALUES (3, 3, 'Разработчик python', 'Какое-то хорошее описание вакансии', 220000, 250000, true);
INSERT INTO hh.vacancy (area_id, employer_id, position_name, description, compensation_from, compensation_to,
                        compensation_gross)
VALUES (4, 4, 'Разработчик node js', 'Какое-то хорошее описание вакансии', 200000, 210000, true);
INSERT INTO hh.vacancy (area_id, employer_id, position_name, description, compensation_from, compensation_to,
                        compensation_gross)
VALUES (5, 5, 'Журналист', 'Какое-то хорошее описание вакансии', 100000, 120000, true);
INSERT INTO hh.vacancy (area_id, employer_id, position_name, description, compensation_from, compensation_to,
                        compensation_gross)
VALUES (6, 6, 'Разработчик на удаленку', 'Какое-то хорошее описание вакансии', 150000, 160000, true);
INSERT INTO hh.vacancy (area_id, employer_id, position_name, description, compensation_from, compensation_to,
                        compensation_gross)
VALUES (7, 5, 'Стажер java', 'Какое-то хорошее описание вакансии', 50000, 100000, true);
INSERT INTO hh.vacancy (area_id, employer_id, position_name, description, compensation_from, compensation_to,
                        compensation_gross)
VALUES (4, 3, 'CEO', 'Какое-то хорошее описание вакансии', 500000, 1000000, true);

INSERT INTO hh.resume (applicant_id, position_name, description, compensation_from)
VALUES (1, 'Разработчик Java', 'Пишу четкий код', 250000);
INSERT INTO hh.resume (applicant_id, position_name, description, compensation_from)
VALUES (2, 'Разработчик fuul stack', 'Какое-то описание', 200000);
INSERT INTO hh.resume (applicant_id, position_name, description, compensation_from)
VALUES (3, 'Аналитик', 'Какое-то описание', 150000);
INSERT INTO hh.resume (applicant_id, position_name, description, compensation_from)
VALUES (4, 'Терпила', 'делаю все что угодно за деньги', 100000);

INSERT INTO hh.response (vacancy_id, resume_id, status)
VALUES (1, 1, 'interview');
INSERT INTO hh.response (vacancy_id, resume_id, status)
VALUES (2, 2, 'denial');
INSERT INTO hh.response (vacancy_id, resume_id, status)
VALUES (2, 3, 'in_work');
INSERT INTO hh.response (vacancy_id, resume_id, status)
VALUES (4, 4, 'interview');
INSERT INTO hh.response (vacancy_id, resume_id, status)
VALUES (5, 1, 'interview');
INSERT INTO hh.response (vacancy_id, resume_id, status)
VALUES (5, 3, 'interview');
INSERT INTO hh.response (vacancy_id, resume_id, status)
VALUES (7, 4, 'interview');
INSERT INTO hh.response (vacancy_id, resume_id, status)
VALUES (8, 3, 'interview');
INSERT INTO hh.response (vacancy_id, resume_id, status)
VALUES (9, 4, 'interview');
INSERT INTO hh.response (vacancy_id, resume_id, status)
VALUES (10, 4, 'interview');
INSERT INTO hh.response (vacancy_id, resume_id, status)
VALUES (13, 2, 'interview');
INSERT INTO hh.response (vacancy_id, resume_id, status)
VALUES (1, 3, 'interview');