USE adventureworks;

-- 1. Crear un procedimiento que recibe como parámetro una fecha y muestre la cantidad de órdenes ingresadas en esa fecha.

SELECT * FROM salesorderheader LIMIT 5;


DELIMITER $$

CREATE PROCEDURE SP_ordenesFecha (IN fecha DATE)
BEGIN
	SELECT COUNT(*) FROM salesorderheader WHERE DATE(OrderDate) = fecha;
END $$

DELIMITER ;


CALL SP_ordenesFecha('2001-07-01');



-- 2. Crear una función que calcule el valor nominal de un margen bruto determinado por el usuario 
-- a partir del precio de lista de los productos.

 -- SET GLOBAL log_bin_trust_function_creators = 1;


DELIMITER $$

CREATE FUNCTION F_margen(margen DECIMAL(10,2), precio DECIMAL(10,2)) RETURNS DECIMAL(10,2) 
BEGIN
    RETURN(precio * margen);
END $$

DELIMITER ;



SELECT F_margen (200, 1.4) margen;



-- 3. Obtner un listado de productos en orden alfabético que muestre cuál debería ser el valor de precio de lista, 
-- si se quiere aplicar un margen bruto del 20%, utilizando la función creada en el punto 2, sobre el campo StandardCost.
-- Mostrando tambien el campo ListPrice y la diferencia con el nuevo campo creado.


SELECT Name, StandardCost, F_margen(1.2, StandardCost) lista_update, ListPrice, (ROUND(ListPrice - F_margen(1.2, StandardCost),2)) diferencia  
FROM product ORDER BY Name



-- 4. Crear un procedimiento que reciba como parámetro una fecha desde y una hasta, y muestre un listado con los Id de 
-- los diez Clientes que más costo de transporte tienen entre esas fechas (campo Freight).


DELIMITER $$

CREATE PROCEDURE SP_costoTransporte (IN desde DATE, IN hasta DATE)
BEGIN
	SELECT CustomerID FROM salesorderheader WHERE OrderDate BETWEEN desde AND hasta GROUP BY CustomerID ORDER BY SUM(Freight) DESC LIMIT 10;
END $$

DELIMITER ;


CALL SP_costoTransporte('2001-07-13','2001-08-05');



-- 5. Crear un procedimiento que permita realizar la insercción de datos en la tabla shipmethod.


DESCRIBE shipmethod;



DELIMITER $$

CREATE PROCEDURE SP_insertShipmethod (IN Name_p VARCHAR(50), IN ShipBase_p DOUBLE, IN ShipRate_p DOUBLE)
BEGIN
	INSERT INTO shipmethod (Name, ShipBase, ShipRate, ModifiedDate)	
	VALUES (Name_p, ShipBase_p, ShipRate_p, CURRENT_TIMESTAMP);
END $$

DELIMITER ;


CALL SP_insertShipmethod('Registro Nuevo', 5.3, 8.2);





