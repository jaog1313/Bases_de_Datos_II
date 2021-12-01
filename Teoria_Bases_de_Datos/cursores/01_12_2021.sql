/*
create or replace procedure procInfoDept
is
	cursor infoDept_cursor is
		select dname, count(empno), avg(sal)
		from emp inner join dept
		on emp.deptno = dept.deptno
		group by dname;
		infoDeptRecord infoDept_cursor%rowtype;
	begin
		open infoDept_cursor;
		loop
			fetch infoDept_cursor into infoDeptRecord
			exit when infoDept_cursor%NotFound;
			dbms.output.put_line("Nombre departamento" || info
*/

create or replace procedure procFiveSal
is
cursor infoemp_cursor is
	select ename, sal
	from emp
	order by sal desc;
empRecord infoemp_cursor%rowtype; --Tiene dos columnas
begin
	open infoemp_cursor;
	fetch infoemp_cursor into empRecord;
	while infoemp_cursor%rowcount < 6 loop
		dbms_output.put_line('Nombre empleado ' || empRecord.ename);
		dbms_output.put_line('Salario ' || empRecord.sal);
		fetch infoemp_cursor into empRecord;
	end loop;
end procFiveSal;
