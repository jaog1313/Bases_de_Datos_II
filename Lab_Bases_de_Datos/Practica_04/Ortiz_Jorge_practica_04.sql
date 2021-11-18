END;
/
-- Funcion 01
CREATE OR REPLACE FUNCTION get_deptid_by_name(
	p_dnombre departamentos.dnombre%TYPE
)
RETURN NUMBER
IS
	v_deptid NUMBER := 0;
BEGIN
	SELECT dept.deptno
	INTO v_deptid
	FROM departamentos
	WHERE LOWER(departamentos.dnombre) = LOWER(p_dnombre);
	RETURN v_deptid;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('No se encontro el departamento con el nombre' || p_dnombre);
		RETURN -1;
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( SQLERRM );
		RETURN -1;
END;
/

-- Primer llamado de la funcion get_deptid_by_name, pasandole como parametro un dato valido debería retornar el id del departamento
DECLARE
	v_text VARCHAR2 := 'CONTABILIDAD';
	v_id NUMBER := 0;
BEGIN
	v_id = get_deptid_by_name(v_text);
	IF v_id <> -1 THEN
	
		DBMS_OUTPUT.PUT_LINE( 'El id del departamento con nombre ' || v_text || ' es ' || v_id );
	ELSE
		DBMS_OUTPUT.PUT_LINE( 'El id del departamento con nombre ' || v_text || ' no existe');
		
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( SQLERRM );
END;
/
-- Segundo llamado de la funcion get_deptid_by_name,  pasandole como parametro un dato no valido.
-- Debería retornar -1

DECLARE
	v_text VARCHAR2 := 'CONTABILIDAD_qwe';
	v_id NUMBER := 0;
BEGIN
	v_id = get_deptid_by_name(v_text);
	IF v_id <> -1 THEN
	
		DBMS_OUTPUT.PUT_LINE( 'El id del departamento con nombre ' || v_text || ' es ' || v_id );
	ELSE
		DBMS_OUTPUT.PUT_LINE( 'El id del departamento con nombre ' || v_text || ' no existe');
		
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( SQLERRM );
END;
/

-- Punto 02

CREATE OR REPLACE FUNCTION get_count_emp_by_name(
	p_dnombre  departamentos.dnombre%TYPE
)
RETURN NUMBER
IS
	v_id NUMBER := 0;
	v_cont number := 0;
BEGIN
	v_id = get_deptid_by_name(p_dnombre);
	SELECT COUNT(*)
	into v_cont
	from empleados
	where deptid = v_id;
	RETURN v_cont;
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( SQLERRM );
		RETURN -1;
END;
/

-- Primer llamado de la funcion get_count_emp_by_name, pasandole como parametro un dato valido debería retornar el numero de empleados
DECLARE
	v_text VARCHAR2 := 'CONTABILIDAD';
	v_cont NUMBER := 0;
BEGIN
	v_cont = get_count_emp_by_name(v_text);
	IF v_id <> 0 THEN
	
		DBMS_OUTPUT.PUT_LINE( 'El departamento  ' || v_text || ' tiene' || v_cont || ' empleados' );
	ELSE
		DBMS_OUTPUT.PUT_LINE( 'El  departamento con nombre ' || v_text || ' no existe');
		
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( SQLERRM );
END;
/
