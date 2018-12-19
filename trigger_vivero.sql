CREATE OR REPLACE FUNCTION incorporar_pedido() RETURNS TRIGGER AS $$
	BEGIN
	   RAISE NOTICE 'Hay un nuevo pedido';

	   UPDATE mydb.PRODUCTO
	   SET stock=mydb.PRODUCTO.stock-NEW.cantidad 
	   WHERE cod_producto=NEW.cod_producto;
           RETURN NULL;
	END;
$$ LANGUAGE plpgsql;



CREATE TRIGGER nueva_compra
AFTER INSERT
ON mydb.CLIENTE_PRODUCTO
FOR EACH ROW
	EXECUTE PROCEDURE incorporar_pedido();


INSERT INTO mydb . CLIENTE_PRODUCTO ( dni_cliente , dni_empleado , cod_producto , fecha_compra , cantidad ) VALUES ('12453423D', '25983746D', 1, '12-01-2018', 2);
