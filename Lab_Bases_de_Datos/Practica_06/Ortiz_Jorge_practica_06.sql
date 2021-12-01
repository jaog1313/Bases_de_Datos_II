end;
/
/*
EJERCICIO 01
*/
DECLARE
	v_emp_id empleados.empid%type;
	v_emp_nombre empleados.enombre%type;
	CURSOR c_emp_diez IS
		SELECT empid, enombre
		FROM empleados;
BEGIN
	OPEN c_emp_diez;
	DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('INICIO SALIDA DEL EJERCICIO 01');
	LOOP
		FETCH c_emp_diez INTO v_emp_id, v_emp_nombre;
		EXIT WHEN c_emp_diez%ROWCOUNT > 10 OR c_emp_diez%NOTFOUND;
		
		DBMS_OUTPUT.PUT_LINE('ID EMPLEADO: ' || v_emp_id || ' NOMBRE EMPLEADO: ' || v_emp_nombre);
		
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('FIN SALIDA DEL EJERCICIO 01');
	DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------');
	CLOSE c_emp_diez;
END;
/

/*
EJERCICIO 02
No olvidar el ODERBY
*/

DECLARE
	v_dept_id departamentos.deptid%type;
	v_dept_nombre departamentos.dnombre%type;
	r_dept departamentos%rowtype;
	r_emp empleados%rowtype;
	CURSOR c_info_dept IS
		SELECT *
		FROM departamentos;
	CURSOR c_info_emp( p_dept_id departamentos.deptid%TYPE ) IS
		SELECT *
		FROM empleados
		WHERE deptid = p_dept_id
		ORDER BY salario;
BEGIN
	OPEN c_info_dept;
	DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('INICIO SALIDA DEL EJERCICIO 02');
	LOOP
		FETCH c_info_dept INTO r_dept;
		EXIT WHEN c_info_dept%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('-------------------------------------');
		DBMS_OUTPUT.PUT_LINE(r_dept.dnombre);
		DBMS_OUTPUT.PUT_LINE('-------------------------------------');
		OPEN c_info_emp( r_dept.deptid );
		LOOP
			FETCH c_info_emp INTO r_emp;
			EXIT WHEN c_info_emp%NOTFOUND;
			DBMS_OUTPUT.PUT_LINE(r_emp.enombre || ' ' || r_emp.salario);
		END LOOP;
		
		CLOSE c_info_emp;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('FIN SALIDA DEL EJERCICIO 02');
	DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------');
	CLOSE c_info_dept;
END;
/
