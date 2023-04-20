#AMANDA LOBO DE OLIVEIRA
#CRIAÇÃO DO BANCO ALIMENTOS 
CREATE DATABASE alimentos;

USE alimentos;

#CRIAÇÃO DAS TABELAS COM CHAVES PRIMARIAS E ESTRANGEIRAS + INSERÇÃO DE DADOS NAS TABELAS
CREATE TABLE produto (
	id_produto INT PRIMARY KEY AUTO_INCREMENT,
	nome_produto VARCHAR (130) NOT NULL,
	indicador_produto_ativo CHAR (10) NOT NULL
);

INSERT INTO produto (nome_produto, indicador_produto_ativo)
VALUES ('arroz branco', 'SIM');
INSERT INTO produto (nome_produto, indicador_produto_ativo)
VALUES ('feijão carioca', 'SIM');
INSERT INTO produto (nome_produto, indicador_produto_ativo)
VALUES ('açucar', 'SIM');


CREATE TABLE cliente (
	id_cliente INT PRIMARY KEY AUTO_INCREMENT,
	nome_cliente VARCHAR (30) NOT NULL,
	sobrenome_cliente VARCHAR (80) NOT NULL,
	data_nascimento_cliente DATE,
	email_cliente VARCHAR (100) NOT NULL UNIQUE
);

INSERT INTO cliente (nome_cliente, sobrenome_cliente, data_nascimento_cliente, email_cliente)
VALUES ('Paulo', 'Souza de Oliveira', '1989-05-23', 'paulo.so@gmail.com');
INSERT INTO cliente (nome_cliente, sobrenome_cliente, data_nascimento_cliente, email_cliente)
VALUES ('Claudia', 'Santos', '1956-08-13', 'claudiasss@hotmail.com');
INSERT INTO cliente (nome_cliente, sobrenome_cliente, data_nascimento_cliente, email_cliente)
VALUES ('Camila', 'Martins', '1964-09-07', 'cami_martins@gmail.com');


CREATE TABLE veiculo (
	id_veiculo INT PRIMARY KEY AUTO_INCREMENT,
	placa_veiculo VARCHAR (10) NOT NULL,
	modelo_veiculo VARCHAR (15) NOT NULL,
	marca_veiculo VARCHAR (15) NOT NULL
);

INSERT INTO veiculo (placa_veiculo, modelo_veiculo, marca_veiculo)
VALUES ('BOL1036', 'UNO', 'FIAT');
INSERT INTO veiculo (placa_veiculo, modelo_veiculo, marca_veiculo)
VALUES ('AMD2305', 'MOBI', 'FIAT');
INSERT INTO veiculo (placa_veiculo, modelo_veiculo, marca_veiculo)
VALUES ('OLO0709', 'MARCH', 'NISSAN');

CREATE TABLE regiao (
	id_regiao INT PRIMARY KEY AUTO_INCREMENT,
	nome_regiao VARCHAR (50) NOT NULL
);

INSERT INTO regiao (nome_regiao)
VALUES ('norte');
INSERT INTO regiao (nome_regiao)
VALUES ('sudeste');
INSERT INTO regiao (nome_regiao)
VALUES ('oeste');

CREATE TABLE vendedor (
	id_vendedor INT PRIMARY KEY AUTO_INCREMENT,
	id_regiao INT NOT NULL,
	nome_vendedor VARCHAR (30) NOT NULL,
	sobrenome_vendedor VARCHAR (80) NOT NULL,
    CONSTRAINT FK_regiao_vendedor_id_regiao 
	FOREIGN KEY (id_regiao) REFERENCES regiao(id_regiao)
    );
  
INSERT INTO vendedor (id_regiao, nome_vendedor, sobrenome_vendedor)
VALUES ('1', 'José', 'Dantas');
INSERT INTO vendedor (id_regiao, nome_vendedor, sobrenome_vendedor)
VALUES ('2', 'Bruno', 'Lima');
INSERT INTO vendedor (id_regiao, nome_vendedor, sobrenome_vendedor)
VALUES ('4', 'Flavia', 'Freitas');

CREATE TABLE ponto_estrategico (
	id_ponto_estrategico INT PRIMARY KEY AUTO_INCREMENT,
	id_regiao INT NOT NULL,
    CONSTRAINT FK_regiao_ponto_estrategico_id_regiao
	FOREIGN KEY (id_regiao) REFERENCES regiao(id_regiao)
);

INSERT INTO ponto_estrategico (id_ponto_estrategico, id_regiao)
VALUES ('1', '1');
INSERT INTO ponto_estrategico (id_ponto_estrategico, id_regiao)
VALUES ('2', '2');
INSERT INTO ponto_estrategico (id_ponto_estrategico, id_regiao)
VALUES ('3', '4');

CREATE TABLE utilizacao_veiculo (
	id_utilizacao_veiculo INT PRIMARY KEY AUTO_INCREMENT,
	id_vendedor INT,
	id_veiculo INT,
	data_utilizacao_veiculo DATETIME,
    CONSTRAINT FK_vendedor_utilizacao_veiculo_id_vendedor
    FOREIGN KEY (id_vendedor) REFERENCES vendedor(id_vendedor),
    CONSTRAINT FK_veiculo_utilizacao_veiculo_id_veiculo
    FOREIGN KEY (id_veiculo) REFERENCES veiculo(id_veiculo)
);

INSERT INTO utilizacao_veiculo (id_vendedor, id_veiculo, data_utilizacao_veiculo)
VALUES ('1', '1', '2022-09-12 10:45:25');
INSERT INTO utilizacao_veiculo (id_vendedor, id_veiculo, data_utilizacao_veiculo)
VALUES ('2', '2', '2022-09-06 08:00:09');
INSERT INTO utilizacao_veiculo (id_vendedor, id_veiculo, data_utilizacao_veiculo)
VALUES ('5', '3', '2022-09-06 14:37:02');

CREATE TABLE nota_fiscal (
	numero_nf INT PRIMARY KEY,
	id_cliente INT,
	id_vendedor INT,
    CONSTRAINT FK_cliente_nota_fiscal_id_cliente
	FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    CONSTRAINT FK_vendedor_nota_fiscal_id_vendedor
	FOREIGN KEY (id_vendedor) REFERENCES vendedor(id_vendedor)
);

INSERT INTO nota_fiscal (numero_nf, id_cliente, id_vendedor)
VALUES ('250', '1', '1');
INSERT INTO nota_fiscal (numero_nf, id_cliente, id_vendedor)
VALUES ('7856', '2', '2');
INSERT INTO nota_fiscal (numero_nf, id_cliente, id_vendedor)
VALUES ('10256', '3', '5');

CREATE TABLE itens_nota_fiscal (
id_item_nf INT PRIMARY KEY,
numero_nf INT,
id_produto INT,
quantidade_produto INT,
CONSTRAINT FK_nota_fiscal_itens_nota_fiscal_numero_nf
FOREIGN KEY (numero_nf) REFERENCES nota_fiscal(numero_nf),
CONSTRAINT FK_produto_itens_nota_fiscal_id_produto
FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

INSERT INTO itens_nota_fiscal (id_item_nf, numero_nf, id_produto, quantidade_produto)
VALUES ('1', '250', '1', '5');
INSERT INTO itens_nota_fiscal (id_item_nf, numero_nf, id_produto, quantidade_produto)
VALUES ('2', '7856', '2', '7');
INSERT INTO itens_nota_fiscal (id_item_nf, numero_nf, id_produto, quantidade_produto)
VALUES ('3', '10256', '3', '20');

#ATUALIZAÇÃO DE DADOS
UPDATE cliente SET
sobrenome_cliente = 'Martins Rocha'
WHERE id_cliente = 3;

UPDATE produto SET
indicador_produto_ativo = 'NÃO'
WHERE id_produto = 2;

#SELEÇÃO DE DADOS + SELEÇÃO DE REGISTROS COM JOIN
SELECT id_vendedor, id_veiculo, data_utilizacao_veiculo
FROM utilizacao_veiculo;

SELECT
	*
FROM itens_nota_fiscal
WHERE quantidade_produto <= 15;

SELECT nome_vendedor, sobrenome_vendedor
FROM vendedor
ORDER BY nome_vendedor ASC;

SELECT vendedor.id_vendedor, nome_vendedor, sobrenome_vendedor, id_utilizacao_veiculo, utilizacao_veiculo.id_vendedor, id_veiculo, data_utilizacao_veiculo
FROM vendedor, utilizacao_veiculo
WHERE vendedor.id_vendedor = utilizacao_veiculo.id_vendedor;

SELECT vendedor.id_vendedor, vendedor.nome_vendedor, vendedor.sobrenome_vendedor, regiao.id_regiao, regiao.nome_regiao
FROM vendedor
INNER JOIN regiao
ON vendedor.id_vendedor = regiao.id_regiao;

SELECT id_utilizacao_veiculo, id_vendedor, utilizacao_veiculo.id_veiculo, data_utilizacao_veiculo, veiculo.id_veiculo, placa_veiculo, modelo_veiculo, marca_veiculo
FROM utilizacao_veiculo, veiculo
WHERE utilizacao_veiculo.id_veiculo = veiculo.id_veiculo;

SELECT
	*
FROM vendedor
INNER JOIN ponto_estrategico
ON vendedor.id_vendedor = ponto_estrategico.id_ponto_estrategico
INNER JOIN regiao
ON vendedor.id_vendedor = regiao.id_regiao;

SELECT utilizacao_veiculo.id_utilizacao_veiculo AS id_veiculo, data_utilizacao_veiculo, id_regiao, nome_vendedor, sobrenome_vendedor
FROM vendedor
LEFT JOIN utilizacao_veiculo
ON vendedor.id_vendedor = utilizacao_veiculo.id_vendedor;

SELECT utilizacao_veiculo.id_utilizacao_veiculo AS id_veiculo, data_utilizacao_veiculo, id_regiao, nome_vendedor, sobrenome_vendedor
FROM vendedor
RIGHT JOIN utilizacao_veiculo
ON vendedor.id_vendedor = utilizacao_veiculo.id_vendedor;

#EXCLUSÃO DE DADOS 
DELETE FROM itens_nota_fiscal
WHERE id_item_nf = 3;
