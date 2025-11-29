1. Comandos de Inserção de Dados (INSERT)
Este script (02_dml_insert_data.sql) povoa as principais tabelas, respeitando as chaves estrangeiras (FKs) e a ordem de inserção (tabelas pais antes das tabelas filhas).
SQL
-- ---------------------------------
-- 1. INSERCAO DE ARTISTAS
-- ---------------------------------
INSERT INTO Artista (ID_Artista, Nome_Banda, Genero_Musical, Cache_Contratual) VALUES
(1, 'Os Rockeiros Lentos', 'Rock Alternativo', 450000.00),
(2, 'Electro Groove', 'Música Eletrônica', 200000.00),
(3, 'Samba Raiz Forte', 'Samba', 150000.00);

-- ---------------------------------
-- 2. INSERCAO DE PALCOS
-- ---------------------------------
INSERT INTO Palco (ID_Palco, Nome_Palco, Capacidade_Max, Localizacao) VALUES
(10, 'Palco Principal - Rocha Viva', 60000, 'Área Central'),
(20, 'Palco Secundário - Eletro Hall', 25000, 'Setor Leste');

-- ---------------------------------
-- 3. INSERCAO DE APRESENTACOES
-- ---------------------------------
-- Artista 1 (Rockeiros) no Palco 10
INSERT INTO Apresentacao (ID_Apresentacao, Data_Hora_Inicio, Data_Hora_Fim, Status_Show, ID_Artista, ID_Palco) VALUES
(100, '2025-12-05 22:00:00', '2025-12-05 23:30:00', 'Agendado', 1, 10);
-- Artista 2 (Electro) no Palco 20
INSERT INTO Apresentacao (ID_Apresentacao, Data_Hora_Inicio, Data_Hora_Fim, Status_Show, ID_Artista, ID_Palco) VALUES
(200, '2025-12-05 20:00:00', '2025-12-05 21:00:00', 'Agendado', 2, 20);

-- ---------------------------------
-- 4. INSERCAO DE RIDERS TECNICOS
-- ---------------------------------
INSERT INTO Rider_Tecnico (ID_Rider, Descricao_Equipamentos, Observacoes_Logistica, ID_Apresentacao) VALUES
(1, '10 microfones sem fio, bateria acústica completa, 3 amplificadores valvulados', 'Necessário água mineral gelada na coxia.', 100),
(2, 'Sistema de PA extra para subgraves, mesa de DJ Pioneer DJM-A9, luzes estroboscópicas', 'Checar voltagem 220V no palco.', 200);

-- ---------------------------------
-- 5. INSERCAO DE LOTES E INGRESSOS
-- ---------------------------------
INSERT INTO Lote (ID_Lote, Nome_Lote, Preco, Quantidade_Inicial, Quantidade_Vendida) VALUES
(1000, 'Lote Promocional Pista', 150.00, 10000, 9500),
(2000, 'Lote VIP', 450.00, 2000, 1800);

-- ---------------------------------
-- 6. INSERCAO DE COMPRADORES E TRANSACOES
-- ---------------------------------
INSERT INTO Comprador (ID_Comprador, Nome_Completo, Email, CPF) VALUES
(500, 'Juliana Almeida', 'ju.almeida@email.com', '12345678900'),
(501, 'Marcos Silva', 'marcos.silva@email.com', '09876543211');

-- Transação de Juliana (4 ingressos Pista e 1 VIP)
INSERT INTO Transacao (ID_Transacao, Data_Hora_Venda, Valor_Total, Meio_Pagamento, Status_Pagamento, ID_Comprador) VALUES
(8000, NOW(), (4 * 150.00) + (1 * 450.00), 'Cartão de Crédito', 'Concluído', 500);

-- Transação de Marcos (2 ingressos Pista)
INSERT INTO Transacao (ID_Transacao, Data_Hora_Venda, Valor_Total, Meio_Pagamento, Status_Pagamento, ID_Comprador) VALUES
(8001, NOW(), (2 * 150.00), 'PIX', 'Concluído', 501);

-- ---------------------------------
-- 7. INSERCAO DE INGRESSOS (VINCULADOS A TRANSACAO E LOTE)
-- ---------------------------------
-- Ingressos de Juliana (Transacao 8000)
INSERT INTO Ingresso (Codigo_Unico, Status_Uso, Setor, ID_Lote, ID_Transacao) VALUES
('RMTN001', 'Vendido', 'Pista', 1000, 8000),
('RMTN002', 'Vendido', 'Pista', 1000, 8000),
('RMTN003', 'Vendido', 'Pista', 1000, 8000),
('RMTN004', 'Vendido', 'Pista', 1000, 8000),
('RMTN005', 'Vendido', 'VIP', 2000, 8000);

-- Ingressos de Marcos (Transacao 8001)
INSERT INTO Ingresso (Codigo_Unico, Status_Uso, Setor, ID_Lote, ID_Transacao) VALUES
('RMTN006', 'Vendido', 'Pista', 1000, 8001),
('RMTN007', 'Vendido', 'Pista', 1000, 8001);

-- ---------------------------------
-- 8. INSERCAO DE ACESSOS (Check-in)
-- ---------------------------------
-- Registro de entrada de Juliana e mais um
INSERT INTO Acesso (ID_Acesso, Horario_Entrada, Catraca_ID, Codigo_Unico) VALUES
(9001, '2025-12-05 18:00:00', 'CATA_01', 'RMTN001'),
(9002, '2025-12-05 18:05:00', 'CATA_02', 'RMTN006');
