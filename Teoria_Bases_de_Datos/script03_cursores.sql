/*
ejercicio 1:
procedimiento almacenado que muestra los nombres de los empleados segun cargo al que estan asociados. El cual sera ingresado por el usuario
*/
create or replace procedure prcEmpleadosCargo( v_cargo emp.job%type )
is
	cursor emp_cursor(v_cargo emp.job%type) is
		select ename
		from emp
		where job = v_cargo;
begin
	open emp_cursor;
	loop
		-- lo siguiente fue propuesto por Erika Camacho
		fetch emp_cursor into v_nombre;
		exit when emp_cursor%notfound;
		dbms_output.put_line("Nombre:" || v_nombre);
		-- termina lo propuesto por Erika Camacho
	end loop;
	close emp_cursor;
end prcEmpleadosCargo;
