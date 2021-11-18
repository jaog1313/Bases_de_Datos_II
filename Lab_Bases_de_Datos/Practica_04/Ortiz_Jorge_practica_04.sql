CREATE OR REPLACE FUNCTION get_deptno_by_name(
	p_dname dept.dmane%TYPE
)
RETURN NUMBER
IS
	v_deptno := 0;
BEGIN
	SELECT dept.deptno
	INTO v_deptno
	FROM dept
	WHERE LOWER(dept.dname) = LOWER(p_dname);
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('No se encontro el departamento con el nombre' || p_dname);
		RETURN -1;
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE( SQLERRM );
		RETURN -1;
END;
/
