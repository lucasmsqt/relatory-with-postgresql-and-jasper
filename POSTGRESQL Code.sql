CREATE TABLE produtos (
	id serial4 NOT NULL, 
	nome varchar NOT NULL, 
	fornecedor varchar NOT NULL, 
	valor money NOT NULL, 
	valor_total money NULL, 
	CONSTRAINT produtos_pkey PRIMARY KEY (id) 
)

INSERT INTO produtos (nome,fornecedor,valor) 
VALUES 
('Monitor','Asus',950),
('Mesa','Madereira',250),
('Headset','RedDragon',150),
('Mouse','RedDragon',115.98),
('Teclado','RedDragon',250),
('Gabinete','Pichau',320),
('Xeon','Intel',50),
('Memoria Ram','Kingston',89.56),
('Celular','Samsung',1500),
('SSD','Goldenfir',75.98)

CREATE OR REPLACE FUNCTION atualiza_valor_total()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE produtos 
    SET valor_total = (SELECT SUM(valor) FROM produtos);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql

CREATE TRIGGER trigger_atualiza_valor_total
AFTER INSERT OR UPDATE OF valor ON produtos
FOR EACH ROW
EXECUTE FUNCTION atualiza_valor_total();

UPDATE produtos 
SET valor = 2
WHERE nome = 'Xeon';

SELECT * FROM produtos;
