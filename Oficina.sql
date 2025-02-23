CREATE DATABASE Oficina;
USE Oficina;
show databases;
SELECT * FROM  Equipe;
-- Tabela Equipe 
CREATE TABLE Equipe (
    idEquipe INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(45) NOT NULL
);
SELECT * FROM Clientes;
-- Tabela Clientes
CREATE TABLE Clientes (
    idClientes INT PRIMARY KEY AUTO_INCREMENT,
    NomeCliente VARCHAR(45) NOT NULL,
    Endereco VARCHAR(45),
    Telefone FLOAT
);
select * from veiculos;
-- Tabela Veículos
CREATE TABLE Veiculos (
    idVeiculos INT PRIMARY KEY AUTO_INCREMENT,
    Marca VARCHAR(45) NOT NULL,
    Modelo VARCHAR(45) NOT NULL,
    AnoFabricacao INT,
    Placa CHAR(8) UNIQUE NOT NULL,
    Clientes_idClientes INT,
    Equipe_idEquipe INT,
    FOREIGN KEY (Clientes_idClientes) REFERENCES Clientes(idClientes),
    FOREIGN KEY (Equipe_idEquipe) REFERENCES Equipe(idEquipe)
);
select * from mecanicos;
-- Tabela Mecânicos
CREATE TABLE Mecanicos (
    idMecanicos INT PRIMARY KEY AUTO_INCREMENT,
    CodigoMecanico INT UNIQUE NOT NULL,
    Nome VARCHAR(45) NOT NULL,
    Endereco VARCHAR(45),
    Especialidade VARCHAR(45),
    Servico_idServico INT
);
select * from Mecanicos_Equipe;
-- Tabela Mecânicos_Equipe (Relacionamento entre Mecânicos e Equipe)
CREATE TABLE Mecanicos_Equipe (
    Mecanicos_idMecanicos INT,
    Equipe_idEquipe INT,
    PRIMARY KEY (Mecanicos_idMecanicos, Equipe_idEquipe),
    FOREIGN KEY (Mecanicos_idMecanicos) REFERENCES Mecanicos(idMecanicos),
    FOREIGN KEY (Equipe_idEquipe) REFERENCES Equipe(idEquipe)
);
select * from TabelaReferenciaMaoObra;
-- Tabela Tabela Referência Mão de Obra
CREATE TABLE TabelaReferenciaMaoObra (
    idTabelaReferenciaMaoObra INT PRIMARY KEY AUTO_INCREMENT,
    Descricao VARCHAR(45) NOT NULL,
    ValorMaoObra DECIMAL(8,2) NOT NULL
);
select * from servico;
-- Tabela Serviço
CREATE TABLE Servico (
    idServico INT PRIMARY KEY AUTO_INCREMENT,
    Descricao VARCHAR(45) NOT NULL,
    TabelaReferenciaMaoObra_idTabelaReferenciaMaoObra INT,
    FOREIGN KEY (TabelaReferenciaMaoObra_idTabelaReferenciaMaoObra) REFERENCES TabelaReferenciaMaoObra(idTabelaReferenciaMaoObra)
);

-- Adicionar FK em Mecanicos após criação da tabela Servico
ALTER TABLE Mecanicos
ADD CONSTRAINT fk_mecanico_servico FOREIGN KEY (Servico_idServico) REFERENCES Servico(idServico);
select * from OrdemDeServico;
-- Tabela Ordem de Serviço
CREATE TABLE OrdemDeServico (
    idOrdemServico INT PRIMARY KEY AUTO_INCREMENT,
    NumeroOS INT UNIQUE NOT NULL,
    DataEmissao DATE NOT NULL,
    Valor FLOAT NOT NULL,
    Status VARCHAR(30),
    DataEntrega DATE
);
select * from OrdemDeServico_Servico;
-- Tabela Ordem de Serviço e Serviço (Relacionamento entre Ordem de Serviço e Serviço)
CREATE TABLE OrdemDeServico_Servico (
    OrdemDeServico_idOrdemServico INT,
    Servico_idServico INT,
    Quantidade INT NOT NULL,
    SubtotalMaoObra DECIMAL(8,2),
    PRIMARY KEY (OrdemDeServico_idOrdemServico, Servico_idServico),
    FOREIGN KEY (OrdemDeServico_idOrdemServico) REFERENCES OrdemDeServico(idOrdemServico),
    FOREIGN KEY (Servico_idServico) REFERENCES Servico(idServico)
);
select * from pecas;
-- Tabela Peças
CREATE TABLE Pecas (
    idPecas INT PRIMARY KEY AUTO_INCREMENT,
    Descricao VARCHAR(45) NOT NULL,
    Valor DECIMAL(8,2) NOT NULL
);
select * from OrdemDeServico_Pecas;
-- Tabela Ordem de Serviço e Peças (Relacionamento entre Ordem de Serviço e Peças)
CREATE TABLE OrdemDeServico_Pecas (
    OrdemDeServico_idOrdemServico INT,
    Pecas_idPecas INT,
    Quantidade INT NOT NULL,
    SubtotalPecas DECIMAL(8,2),
    PRIMARY KEY (OrdemDeServico_idOrdemServico, Pecas_idPecas),
    FOREIGN KEY (OrdemDeServico_idOrdemServico) REFERENCES OrdemDeServico(idOrdemServico),
    FOREIGN KEY (Pecas_idPecas) REFERENCES Pecas(idPecas)
);

-- inserindo dados

INSERT INTO Clientes (idClientes, NomeCliente, Endereco, Telefone) VALUES
(1, 'João Silva', 'Rua A, 123', 11987654321),
(2, 'Maria Oliveira', 'Avenida B, 456', 11976543210),
(3, 'Carlos Santos', 'Travessa C, 789', 11965432198);

INSERT INTO Equipe (idEquipe, Nome) VALUES
(1, 'Equipe Alfa'),
(2, 'Equipe Beta'),
(3, 'Equipe Gama');
 
INSERT INTO Veiculos (idVeiculos, Marca, Modelo, AnoFabricacao, Placa, Clientes_idClientes, Equipe_idEquipe) VALUES
(1, 'Toyota', 'Corolla', 2020, 'ABC-1234', 1, 1),
(2, 'Honda', 'Civic', 2018, 'DEF-5678', 2, 2),
(3, 'Ford', 'Focus', 2019, 'GHI-9012', 3, 1);

INSERT INTO TabelaReferenciaMaoObra (idTabelaReferenciaMaoObra, Descricao, ValorMaoObra) VALUES
(1, 'Serviço Básico', 150.00),
(2, 'Serviço Intermediário', 250.00),
(3, 'Serviço Avançado', 400.00);

INSERT INTO Servico (idServico, Descricao, TabelaReferenciaMaoObra_idTabelaReferenciaMaoObra) VALUES
(1, 'Troca de óleo', 1),
(2, 'Alinhamento e balanceamento', 2),
(3, 'Troca de pastilhas de freio', 3);

INSERT INTO Mecanicos (idMecanicos, CodigoMecanico, Nome, Endereco, Especialidade, Servico_idServico) VALUES
(1, 1001, 'Pedro Lima', 'Rua X, 101', 'Suspensão', 1),
(2, 1002, 'Lucas Souza', 'Avenida Y, 202', 'Motor', 2),
(3, 1003, 'Ana Clara', 'Rua Z, 303', 'Freios', 3);

INSERT INTO Mecanicos_Equipe (Mecanicos_idMecanicos, Equipe_idEquipe) VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO Pecas (idPecas, Descricao, Valor) VALUES
(1, 'Óleo Lubrificante 5W30', 50.00),
(2, 'Pastilhas de Freio', 120.00),
(3, 'Filtro de Ar', 35.00);

INSERT INTO OrdemDeServico (idOrdemServico, NumeroOS, DataEmissao, Valor, Status, DataEntrega) VALUES
(1, 10001, '2025-02-15', 500.00, 'Aberta', NULL),
(2, 10002, '2025-02-16', 1200.00, 'Em Andamento', NULL),
(3, 10003, '2025-02-17', 300.00, 'Concluída', '2025-02-18');

INSERT INTO OrdemDeServico_Servico (OrdemDeServico_idOrdemServico, Servico_idServico, Quantidade, SubtotalMaoObra) VALUES
(1, 1, 1, 150.00),
(2, 2, 1, 250.00),
(3, 3, 1, 400.00);

INSERT INTO OrdemDeServico_Pecas (OrdemDeServico_idOrdemServico, Pecas_idPecas, Quantidade, SubtotalPecas) VALUES
(1, 1, 1, 50.00),
(2, 2, 1, 120.00),
(3, 3, 1, 35.00);

--  Filtros com WHERE Statement
SELECT * FROM OrdemDeServico WHERE Status = 'Aberta';
SELECT * FROM Veiculos WHERE Marca = 'Toyota';

-- Definir ordenação dos dados com ORDER BY
SELECT * FROM Clientes ORDER BY NomeCliente ASC;
SELECT * FROM OrdemDeServico ORDER BY DataEmissao DESC;

--  expressões para gerar atributos derivados;
SELECT idOrdemServico, 
       CASE 
           WHEN DataEntrega IS NULL THEN 'Em andamento'
           WHEN DataEntrega > CURDATE() THEN 'Atrasada'
           ELSE 'Concluída'
       END AS Status_Calculado
FROM OrdemDeServico;

-- Condições de filtros HAVING Statement
SELECT S.Descricao AS Servico, 
       COUNT(OSS.Servico_idServico) AS Quantidade
FROM OrdemDeServico_Servico OSS
JOIN Servico S ON OSS.Servico_idServico = S.idServico
GROUP BY S.Descricao
HAVING Quantidade > 0;

-- Recuperações simples com SELECT Statement;
SELECT * FROM OrdemDeServico;
SELECT NomeCliente, Telefone FROM Clientes;


 
 
