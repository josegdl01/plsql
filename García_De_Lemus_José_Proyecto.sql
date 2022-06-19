--Creación de la base de datos sobre la que trabajará el proyecto.

DROP TABLE TIENDAS CASCADE CONSTRAINTS;

CREATE TABLE TIENDAS
(
    ID_TIENDAS NUMBER (3),  --Todas las P. K serán declaradas como números de tres carácteres máximo
    DIRECCION VARCHAR2 (35),
    NUM_EMPLEADOS NUMBER (3),
    TLF NUMBER (9),
    CONSTRAINT TIENDAS_PK PRIMARY KEY (ID_TIENDAS)
);

INSERT INTO tiendas values (1, 'c/Sierpes nº 45', 5, 954565895);
INSERT INTO tiendas values (2, 'c/Amor de Dios nº 57', 4, 954487895);
INSERT INTO tiendas values (3,'c/Feria nº 39', 7, 954754887);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DROP TABLE PROVEEDORES CASCADE CONSTRAINTS;

CREATE TABLE PROVEEDORES 
(
    ID_PROVEEDORES NUMBER (3),
    PAIS VARCHAR (15),
    UNIDADES_VENDIDAS NUMBER (4),
    MARCA VARCHAR2 (15),
    CONSTRAINT PROVEEDORES_PK PRIMARY KEY (ID_PROVEEDORES)
);
ALTER TABLE PROVEEDORES DROP CONSTRAINT MARCAS_1;
ALTER TABLE PROVEEDORES DROP CONSTRAINT UNIDADES;

ALTER TABLE PROVEEDORES ADD CONSTRAINT MARCAS_1 CHECK (UPPER(MARCA) IN ('GIBSON', 'IBANEZ', 'FENDER')); --Restricción sobre las marcas de las guitarras
ALTER TABLE PROVEEDORES ADD CONSTRAINT UNIDADES CHECK (UNIDADES_VENDIDAS >= 0);  -- Lógicamente este número no puede ser negativo

INSERT INTO PROVEEDORES VALUES (1, 'E.E.U.U.', 10, 'Gibson');
INSERT INTO PROVEEDORES VALUES (2, 'E.E.U.U.', 15, 'Fender');
INSERT INTO PROVEEDORES VALUES (3, 'España', 20, 'Ibanez');
INSERT INTO PROVEEDORES VALUES (4, 'México', 5, 'Fender');

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DROP TABLE GUITARRAS CASCADE CONSTRAINTS;

CREATE TABLE GUITARRAS
(
    ID_GUITARRA NUMBER (3) PRIMARY KEY,
    MODELO VARCHAR2 (40),
    NUM_CUERDAS NUMBER (1),
    UNIDADES NUMBER (3),
    PRECIO NUMBER (5),
    TIENDA NUMBER (3),   --FK de TIENDAS
    PROVEEDOR NUMBER (3) -- FK de PROVEEDORES
);
ALTER TABLE GUITARRAS DROP CONSTRAINT CUERDAS;
ALTER TABLE GUITARRAS DROP CONSTRAINT UNIDADES_GUIT;
ALTER TABLE GUITARRAS DROP CONSTRAINT TIENDAS_FK;
ALTER TABLE GUITARRAS DROP CONSTRAINT PROVEEDOR_FK;

ALTER TABLE GUITARRAS ADD CONSTRAINT CUERDAS CHECK (NUM_CUERDAS BETWEEN 6 AND 8); --Sólo trabajan con guitarras de 6, 7 y 8 cuerdas
ALTER TABLE GUITARRAS ADD CONSTRAINT UNIDADES_GUIT CHECK (UNIDADES >= 0);  -- Lógicamente este número no puede ser negativo
ALTER TABLE GUITARRAS ADD CONSTRAINT TIENDAS_FK FOREIGN KEY (TIENDA) REFERENCES TIENDAS(ID_TIENDAS); --F.K de TIENDAS
ALTER TABLE GUITARRAS ADD CONSTRAINT PROVEEDOR_FK FOREIGN KEY (PROVEEDOR) REFERENCES PROVEEDORES(ID_PROVEEDORES); --F.K de PROVEEDORES 

INSERT INTO GUITARRAS VALUES (1, 'Fender Stratocaster', 6, 5, 650, 1, 2);
INSERT INTO GUITARRAS VALUES (2, 'Fender Telecaster', 6, 5, 500, 1, 2);
INSERT INTO GUITARRAS VALUES (3, 'Fender Mustang', 6, 10, 700, 2, 4);
INSERT INTO GUITARRAS VALUES (4 ,'Gibson Les Paul', 6, 5, 890, 2, 1);
INSERT INTO GUITARRAS VALUES (5, 'Gibson SG', 6, 5, 900, 2, 1);
INSERT INTO GUITARRAS VALUES (6, 'Ibanez Super Strat-7', 7, 10, 500, 3, 3);
INSERT INTO GUITARRAS VALUES (7, 'Ibanez Super Strat-8', 7, 5, 600, 3, 3);
INSERT INTO GUITARRAS VALUES (8, 'Ibanez Super Strat-6', 6, 5, 350, 3, 3);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DROP TABLE EMPLEADOS CASCADE CONSTRAINTS;

CREATE TABLE EMPLEADOS 
(
    ID_EMPLEADOS NUMBER (3) PRIMARY KEY,
    PUESTO VARCHAR2 (20),
    TIENDA NUMBER (3),   -- FK de TIENDAS
    DIRECCION VARCHAR2 (35),
    TELEFONO NUMBER (9)
);
ALTER TABLE EMPLEADOS DROP CONSTRAINT TIENDAS_FK2;
ALTER TABLE EMPLEADOS DROP CONSTRAINT PUESTO;

ALTER TABLE EMPLEADOS ADD CONSTRAINT TIENDAS_FK2 FOREIGN KEY (TIENDA) REFERENCES TIENDAS(ID_TIENDAS); --F.K de TIENDAS
ALTER TABLE EMPLEADOS ADD CONSTRAINT PUESTO CHECK (UPPER(PUESTO) IN ('VENDEDOR', 'LUTHIER', 'ENCARGADO', 'LIMPIADOR')); --Restricción sobre los puestos de los empleados

INSERT INTO EMPLEADOS VALUES (1, 'Limpiador', 1,'c/ Feria 4 Bajo H', 652154654);
INSERT INTO EMPLEADOS VALUES (2, 'Encargado', 1,'c/ Relator 5 Bajo F', 758496532);
INSERT INTO EMPLEADOS VALUES (3, 'Vendedor', 1,'c/ Castellar 17 Bajo H', 626545854);
INSERT INTO EMPLEADOS VALUES (4, 'Luthier', 1,'c/ Sierpes 21 Bajo H', 63607703);
INSERT INTO EMPLEADOS VALUES (5, 'Luthier', 1,'c/ Santa Ana 45 Bajo H', 615457884);
INSERT INTO EMPLEADOS VALUES (6, 'Vendedor', 2,'c/ Feria 6 Bajo F', 636096590);
INSERT INTO EMPLEADOS VALUES (7, 'Encargado', 2,'c/ Santa Clara 17', 722418736);
INSERT INTO EMPLEADOS VALUES (8, 'Luthier', 2,'c/ Sierpes 21', 651070449);
INSERT INTO EMPLEADOS VALUES (9, 'Luthier', 2,'c/ Relator 10 1º D', 651070450);
INSERT INTO EMPLEADOS VALUES (10, 'Limpiador', 3,'c/ Feria 4 Bajo F', 625456955);
INSERT INTO EMPLEADOS VALUES (11, 'Encargado', 3,'c/ Conde Barajas 25', 721232015);
INSERT INTO EMPLEADOS VALUES (12, 'Vendedor', 3,'c/ Castellar 44 Bajo H', 685476622);
INSERT INTO EMPLEADOS VALUES (13, 'Luthier', 3,'c/ San Juan de la Palma 3', 602201622);
INSERT INTO EMPLEADOS VALUES (14, 'Luthier', 3,'c/ Santa Clara 45 3º H', 695847600);
INSERT INTO EMPLEADOS VALUES (15, 'Vendedor', 3,'c/ Feria 54', 614545256);
INSERT INTO EMPLEADOS VALUES (16, 'Limpiador', 3,'c/ San Jacinto 65', 747548166);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DROP TABLE CLIENTES CASCADE CONSTRAINTS;

CREATE TABLE CLIENTES 
(
    ID_CLIENTES NUMBER (3),
    PRODUCTO NUMBER (3),  --FK de GUITARRA
    TIENDA NUMBER (3),
    NUM_PEDIDO VARCHAR2 (9) PRIMARY KEY,
    SOCIO VARCHAR2 (5) CHECK (UPPER(SOCIO) IN ('SI', 'NO'))  --He creado este atributo con esta restricción al no saber muy bien cómo crear un booleano
);
ALTER TABLE CLIENTES DROP CONSTRAINT GUITARRA_FK;
ALTER TABLE CLIENTES DROP CONSTRAINT TIENDAS_FK3;

ALTER TABLE CLIENTES ADD CONSTRAINT GUITARRA_FK FOREIGN KEY (PRODUCTO) REFERENCES GUITARRA(ID_GUITARRA);
ALTER TABLE CLIENTES ADD CONSTRAINT TIENDAS_FK3 FOREIGN KEY (TIENDA) REFERENCES TIENDAS(ID_TIENDAS);

INSERT INTO CLIENTES VALUES (1, 2, 1, 212325,'no');
INSERT INTO CLIENTES VALUES (2, 8, 3, 212326,'si');
INSERT INTO CLIENTES VALUES (3, 1, 1, 212327,'si');
INSERT INTO CLIENTES VALUES (4, 3, 2, 212328,'no');
INSERT INTO CLIENTES VALUES (1, 7, 3, 212329,'no');
INSERT INTO CLIENTES VALUES (4, 6, 3, 212330,'si');
INSERT INTO CLIENTES VALUES (2, 5, 2, 212331,'no');


--Procedimientos y funciones--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

set serveroutput on;

create or replace procedure buscar_empleado(iden empleados.id_empleados%type) as  -- Este procedimiento busca un empleado y nos devuelve sus datos.  
    
    cursor emp is 
        select * from empleados where empleados.id_empleados = iden;
        
        x number;  z number;  yy number;
        
        y varchar2(20); xx varchar2(35);
    
    begin
        
        open emp;
        
        fetch emp into x,y,z,xx,yy;
        
        dbms_output.put_line('El ID de este empleado es: ' || x);
        dbms_output.put_line('El puesto de este empleado es: ' || y);
        dbms_output.put_line('La tienda en la que trabaja este empleado es la tienda número ' || z);
        dbms_output.put_line('La dirección de este empleado es: ' || xx);
        dbms_output.put_line('El teléfono de este empleado es: ' || yy);
        
        close emp;
    end;
    /

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
create or replace procedure subir_precio as  -- Este procedimiento aumenta el precio de los productos en 50 euros.

    begin
        update guitarras set precio = precio + 50;
    end;
    /

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
create or replace function precio_venta(iden tiendas.id_tiendas%type)   -- Esta función nos devuelve el valor de una tienda sumando el precio de todos sus productos.
return number
is

    numer number;
    
    cursor precios is 
        select sum(guitarra.precio) from guitarra,tiendas 
        where iden = guitarra.id_guitarra and guitarra.tienda = tiendas.id_tiendas;

    begin
        
        open precios;
        loop
            fetch precios into numer;
        
            exit when precios%notfound;
        end loop;
        
        close precios;
        
        
        return numer;
    end;
    /
    
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
create or replace function comprueba_socio(iden empleados.id_empleados%type)  -- Esta función comprueba si un cliente es socio o no.
return varchar
is
    
    socio varchar2 (5);
    
    cli clientes%rowtype;    

    begin
        select * into cli from clientes where iden = clientes.id_clientes;
        
        socio := cli.socio;
        
        if (lower(socio) like 'si') then
            return 'Este cliente es socio.';
            
        elsif (lower(socio) like 'no') then
            return 'Este cliente no es socio.';
            
        else 
            return 'Entrada no válida.';
            
        end if;
    end;
    /
    
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
declare

    x number;
    
    cad varchar2 (50);
    
begin
    buscar_empleado(&id1);
    
    subir_precio;
    
    select precio_venta(&id2) into x from dual;
    
    select comprueba_socio(&id3) into cad from dual;
end;
/