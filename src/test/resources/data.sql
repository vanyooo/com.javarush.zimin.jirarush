---------  users ----------------------
delete
from USER_ROLE;
delete
from CONTACT;
delete
from PROFILE;

delete
from ACTIVITY;
ALTER TABLE ACTIVITY ALTER COLUMN ID RESTART WITH 1;

delete
from TASK;
ALTER TABLE TASK ALTER COLUMN ID RESTART WITH 1;

delete
from SPRINT;
ALTER TABLE SPRINT ALTER COLUMN ID RESTART WITH 1;

delete
from PROJECT;
ALTER TABLE PROJECT ALTER COLUMN ID RESTART WITH 1;

delete
from USERS;
ALTER TABLE USERS ALTER COLUMN ID RESTART WITH 1;

insert into USERS (EMAIL, PASSWORD, FIRST_NAME, LAST_NAME, DISPLAY_NAME, LOCALE)
values ('user@gmail.com', '{noop}password', 'userFirstName', 'userLastName', 'userDisplayName', 'ru'),
       ('admin@gmail.com', '{noop}admin', 'adminFirstName', 'adminLastName', 'adminDisplayName', 'ru'),
       ('guest@gmail.com', '{noop}guest', 'guestFirstName', 'guestLastName', 'guestDisplayName', 'ru'),
       ('manager@gmail.com', '{noop}manager', 'managerFirstName', 'managerLastName', 'managerDisplayName', 'ru');

-- 0 DEV
-- 1 ADMIN
-- 2 MANAGER

insert into USER_ROLE (USER_ID, ROLE)
values (1, 0),
       (2, 0),
       (2, 1),
       (4, 2);

insert into PROFILE (ID, LAST_FAILED_LOGIN, LAST_LOGIN, MAIL_NOTIFICATIONS)
values (1, null, null, 49),
       (2, null, null, 14);

insert into CONTACT (ID, CODE, VALUE)
values (1, 'skype', 'userSkype'),
       (1, 'mobile', '+01234567890'),
       (1, 'website', 'user.com'),
       (2, 'github', 'adminGitHub'),
       (2, 'tg', 'adminTg');


insert into PROJECT (code, title, description, type_code, parent_id)
values ('PR1', 'PROJECT-1', 'test project 1', 'task_tracker', null),
       ('PR2', 'PROJECT-2', 'test project 2', 'task_tracker', 1);

insert into SPRINT (status_code, startpoint, endpoint, code, project_id)
values ('finished', '2023-05-01 08:05:10', '2023-05-07 17:10:01', 'SP-1.001', 1),
       ('active', '2023-05-01 08:06:00', null, 'SP-1.002', 1),
       ('active', '2023-05-01 08:07:00', null, 'SP-1.003', 1),
       ('planning', '2023-05-01 08:08:00', null, 'SP-1.004', 1),
       ('active', '2023-05-10 08:06:00', null, 'SP-2.001', 2),
       ('planning', '2023-05-10 08:07:00', null, 'SP-2.002', 2),
       ('planning', '2023-05-10 08:08:00', null, 'SP-2.003', 2);

insert into TASK (TITLE, TYPE_CODE, STATUS_CODE, PROJECT_ID, SPRINT_ID, STARTPOINT)
values ('Data', 'epic', 'in_progress', 1, 1, '2023-05-15 09:05:10'),
       ('Trees', 'epic', 'in_progress', 1, 1, '2023-05-15 12:05:10'),
       ('task-3', 'task', 'ready_for_test', 2, 5, '2023-06-14 09:28:10'),
       ('task-4', 'task', 'ready_for_review', 2, 5, '2023-06-14 09:28:10'),
       ('task-5', 'task', 'todo', 2, 5, '2023-06-14 09:28:10'),
       ('task-6', 'task', 'done', 2, 5, '2023-06-14 09:28:10'),
       ('task-7', 'task', 'canceled', 2, 5, '2023-06-14 09:28:10'),

       ('task-8', 'task', 'in_progress', 2, 5, '2023-06-14 09:28:10'),
       ('task-9', 'task', 'ready_for_review', 2, 5, '2023-06-14 09:28:10'),
       ('task-10', 'task', 'in_progress', 2, 5, '2023-06-14 09:28:10'),
       ('task-11', 'task', 'canceled', 2, 5, '2023-06-14 09:28:10'),

       ('task-12', 'task', 'test', 2, 5, '2023-06-14 09:28:10'),
       ('task-13', 'done', 'canceled', 2, 5, '2023-06-14 09:28:10'),
       ('task-14', 'task', 'canceled', 2, 5, '2023-06-14 09:28:10');


insert into ACTIVITY(AUTHOR_ID, TASK_ID, UPDATED, COMMENT, TITLE, DESCRIPTION, ESTIMATE, TYPE_CODE, STATUS_CODE,
                     PRIORITY_CODE)
values (1, 1, '2023-05-15 09:05:10', null, 'Data', null, 3, 'epic', 'in_progress', 'low'),
       (2, 1, '2023-05-15 12:25:10', null, 'Data', null, null, null, null, 'normal'),
       (1, 1, '2023-05-15 14:05:10', null, 'Data', null, 4, null, null, null),
       (1, 2, '2023-05-15 12:05:10', null, 'Trees', 'Trees desc', 4, 'epic', 'in_progress', 'normal'),


       (1, 8, '2023-06-14 12:05:10', null, 'task-8', null, null, null, 'in_progress', null),

       (1, 9, '2023-06-14 12:05:10', null, 'task-9', null, null, null, 'in_progress', null),
       (1, 9, '2023-06-14 12:05:15', null, 'task-9', null, null, null, 'ready_for_review', null),

       (1, 10, '2023-06-14 12:05:10', null, 'task-10', null, null, null, 'in_progress', null),
       (1, 10, '2023-06-14 12:05:15', null, 'task-10', null, null, null, 'ready_for_review', null),
       (1, 10, '2023-06-14 12:05:25', null, 'task-10', null, null, null, 'in_progress', null),

       (1, 11, '2023-06-14 12:05:10', null, 'task-11', null, null, null, 'in_progress', null),
       (1, 11, '2023-06-14 12:05:15', null, 'task-11', null, null, null, 'canceled', null),

       (1, 12, '2023-06-14 12:05:10', null, 'task-12', null, null, null, 'test', null),

       (1, 13, '2023-06-14 12:05:10', null, 'task-13', null, null, null, 'test', null),
       (1, 13, '2023-06-14 12:05:25', null, 'task-13', null, null, null, 'done', null),

       (1, 14, '2023-06-14 12:05:10', null, 'task-14', null, null, null, 'test', null),
       (1, 14, '2023-06-14 12:05:15', null, 'task-14', null, null, null, 'canceled', null);


insert into USER_BELONG (OBJECT_ID, OBJECT_TYPE, USER_ID, USER_TYPE_CODE, STARTPOINT, ENDPOINT)
values (1, 2, 2, 'task_developer', '2023-06-14 08:35:10', '2023-06-14 08:55:00'),
       (1, 2, 2, 'task_reviewer', '2023-06-14 09:35:10', null),
--        (1, 2, 1, 'task_developer', '2023-06-12 11:40:00', '2023-06-12 12:35:00'),
       (1, 2, 1, 'task_developer', '2023-06-13 12:35:00', null),
       (1, 2, 1, 'task_tester', '2023-06-14 15:20:00', null),
       (2, 2, 2, 'task_developer', '2023-06-08 07:10:00', null),
       (2, 2, 1, 'task_developer', '2023-06-09 14:48:00', null),
       (2, 2, 1, 'task_tester', '2023-06-10 16:37:00', null);

-- insert into ACTIVITY (AUTHOR_ID, TASK_ID, UPDATED, STATUS_CODE ) values (
--     1, 1, '2023-05-15 09:05:10', 'in_progress')