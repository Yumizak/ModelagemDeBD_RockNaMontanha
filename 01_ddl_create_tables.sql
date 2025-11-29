SQL
-- Criação do esquema do Banco de Dados
-- Dependendo do SGBD (ex: MySQL, PostgreSQL), pode ser necessário usar um comando CREATE DATABASE
-- Exemplo: CREATE DATABASE festival_rock_montanha;
-- USE festival_rock_montanha;

-- ---------------------------------
-- 1. TABELA ARTISTA (Entidade Pai)
-- ---------------------------------
CREATE TABLE Artista (
    ID_Artista INT PRIMARY KEY,
    Nome_Banda VARCHAR(100) NOT NULL,
    Genero_Musical VARCHAR(50),
    Cache_Contratual DECIMAL(10, 2)
);

-- ---------------------------------
-- 2. TABELA PALCO (Entidade Pai)
-- ---------------------------------
CREATE TABLE Palco (
    ID_Palco INT PRIMARY KEY,
    Nome_Palco VARCHAR(100) NOT NULL,
    Capacidade_Max INT NOT NULL,
    Localizacao VARCHAR(100)
);

-- ---------------------------------
-- 3. TABELA APRESENTACAO (Entidade com Chaves Estrangeiras)
-- ---------------------------------
CREATE TABLE Apresentacao (
    ID_Apresentacao INT PRIMARY KEY,
    Data_Hora_Inicio DATETIME NOT NULL,
    Data_Hora_Fim DATETIME NOT NULL,
    Status_Show VARCHAR(50) NOT NULL, -- Ex: Agendado, Em Andamento, Concluído
    ID_Artista INT NOT NULL,
    ID_Palco INT NOT NULL,
    
    -- Chaves Estrangeiras
    FOREIGN KEY (ID_Artista) REFERENCES Artista(ID_Artista),
    FOREIGN KEY (ID_Palco) REFERENCES Palco(ID_Palco)
);

-- ---------------------------------
-- 4. TABELA RIDER_TECNICO (Entidade 1:1 com APRESENTACAO)
-- ---------------------------------
CREATE TABLE Rider_Tecnico (
    ID_Rider INT PRIMARY KEY,
    Descricao_Equipamentos TEXT,
    Observacoes_Logistica TEXT,
    ID_Apresentacao INT UNIQUE NOT NULL, -- UNIQUE garante o relacionamento 1:1
    
    -- Chave Estrangeira
    FOREIGN KEY (ID_Apresentacao) REFERENCES Apresentacao(ID_Apresentacao)
);

-- ---------------------------------
-- 5. TABELA COMPRADOR (Entidade Pai)
-- ---------------------------------
CREATE TABLE Comprador (
    ID_Comprador INT PRIMARY KEY,
    Nome_Completo VARCHAR(150) NOT NULL,
    Email VARCHAR(150) UNIQUE NOT NULL,
    CPF VARCHAR(11) UNIQUE NOT NULL,
    Telefone VARCHAR(20)
);

-- ---------------------------------
-- 6. TABELA TRANSACAO (Entidade com Chave Estrangeira)
-- ---------------------------------
CREATE TABLE Transacao (
    ID_Transacao INT PRIMARY KEY,
    Data_Hora_Venda DATETIME NOT NULL,
    Valor_Total DECIMAL(10, 2) NOT NULL,
    Meio_Pagamento VARCHAR(50),
    Status_Pagamento VARCHAR(50) NOT NULL, -- Ex: Concluído, Pendente, Falhou
    ID_Comprador INT NOT NULL,
    
    -- Chave Estrangeira
    FOREIGN KEY (ID_Comprador) REFERENCES Comprador(ID_Comprador)
);

-- ---------------------------------
-- 7. TABELA LOTE (Entidade Pai)
-- ---------------------------------
CREATE TABLE Lote (
    ID_Lote INT PRIMARY KEY,
    Nome_Lote VARCHAR(100) NOT NULL,
    Preco DECIMAL(10, 2) NOT NULL,
    Quantidade_Inicial INT NOT NULL,
    Quantidade_Vendida INT DEFAULT 0 -- Valor padrão para a contagem
);

-- ---------------------------------
-- 8. TABELA INGRESSO (Entidade com Chaves Estrangeiras)
-- ---------------------------------
CREATE TABLE Ingresso (
    Codigo_Unico VARCHAR(15) PRIMARY KEY, -- PK baseada no código único de rastreamento
    Status_Uso VARCHAR(50) NOT NULL,    -- Ex: Vendido, Utilizado, Cancelado
    Setor VARCHAR(50),
    ID_Lote INT NOT NULL,
    ID_Transacao INT NOT NULL,
    
    -- Chaves Estrangeiras
    FOREIGN KEY (ID_Lote) REFERENCES Lote(ID_Lote),
    FOREIGN KEY (ID_Transacao) REFERENCES Transacao(ID_Transacao)
);

-- ---------------------------------
-- 9. TABELA ACESSO (Entidade 1:1 com INGRESSO)
-- ---------------------------------
CREATE TABLE Acesso (
    ID_Acesso INT PRIMARY KEY,
    Horario_Entrada DATETIME NOT NULL,
    Catraca_ID VARCHAR(20),
    Codigo_Unico VARCHAR(15) UNIQUE NOT NULL, -- UNIQUE garante o relacionamento 1:1
    
    -- Chave Estrangeira
    FOREIGN KEY (Codigo_Unico) REFERENCES Ingresso(Codigo_Unico)
);
