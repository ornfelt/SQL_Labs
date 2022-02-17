/* old:
alter table employees add manager_id int;
alter table employees add supervisor_id int

alter table departments
add constraint fk_departments_manager_id
foreign key (manager)
references employees(id)
on update cascade
on delete restrict;

alter table projects
add constraint fk_projects_supervisor
foreign key (supervisor)
references employees(id)
on update cascade
on delete restrict;

alter table project_members
add constraint fk_project_members_e_id
foreign key (e_id)
references employees(id)
on update cascade
on delete restrict;

alter table project_members
add constraint fk_project_members_p_id
foreign key (p_id)
references employees(id)
on update cascade
on delete restrict;

*/

