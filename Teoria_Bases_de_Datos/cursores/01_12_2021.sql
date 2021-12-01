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
