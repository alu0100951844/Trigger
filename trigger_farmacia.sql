CREATE OR REPLACE FUNCTION check_total_negativo() RETURNS TRIGGER AS $$
	BEGIN

		IF (NEW.total_gastado < 0) THEN
			RAISE NOTICE 'TOTAL_GASTADO cannot be < 0';

			UPDATE mydb.Compra_Cliente_Credito 
			SET total_gastado = 0 
			WHERE mydb.Compra_Cliente_Credito.dni = NEW.dni ;

		END IF;
                RETURN NULL;

	END;
$$ LANGUAGE plpgsql;



CREATE TRIGGER total_negativo 
AFTER INSERT
ON mydb.Compra_Cliente_Credito
FOR EACH ROW
	EXECUTE PROCEDURE check_total_negativo();


INSERT INTO mydb.Compra_Cliente_Credito (dni, cod_factura, nombre_cliente, tlf_cliente, datos_bancarios, fecha_cobro, total_gastado) VALUES ('67329045H', 3, 'María Isabel Pérez Sosa', 865184766, 'ES8261563981383782643636', '2019-02-24', -130);
