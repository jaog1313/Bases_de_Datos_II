end;
/
create or replace package pkg_empleado is
begin
end pkg_empleado;
/

create or replace package body pkg_empleado is
	IPC_2021 constant number(10,3) := 0.046;
begin
	-- Procedimiento que actualiza el salario de un empleado dados su id y
	-- el nuevo salari por parametros.
	create or replace procedure proc_aumento(
		prm_id empleados.empid%type,
		prm_nuevo_sal empleados.salario%type
		)
		is
			mal_salario exception;
		begin
		
		exception
			when mal_salario then
				DBMS_OUTPUT.PUT_LINE('El salario no se puede aumentar mas del valor del IPC');
			WHEN OTHERS THEN
				DBMS_OUTPUT.PUT_LINE( SQLERRM );
		end proc_aumento;
	
	create or replace procedure validarAumento(
		prm_sal empleados.salario%type
		)
		is
		
		begin
		
		exception
		
		end  validarAumento;
	exception
end pkg_empleado;
