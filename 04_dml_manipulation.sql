SQL
-- 1. UPDATE: Atualizar o Status de um show (Apresentação 100) para 'Em Andamento'.
-- Esta alteração seria feita pelo Gerente de Palco ao iniciar o show.
UPDATE Apresentacao
SET Status_Show = 'Em Andamento'
WHERE ID_Apresentacao = 100;

-- 2. UPDATE: Corrigir o preço de um lote de ingressos (Lote VIP) após reajuste.
UPDATE Lote
SET Preco = 500.00 -- Aumenta o preço de 450.00 para 500.00
WHERE ID_Lote = 2000;

-- 3. UPDATE: Mudar o status de uso de um ingresso que teve o check-in registrado (RMTN001)
-- (Embora o INSERT já o tenha feito, este comando garante a consistência, ativando a regra de negócio)
UPDATE Ingresso
SET Status_Uso = 'Utilizado'
WHERE Codigo_Unico IN ('RMTN001', 'RMTN006');
3.2. Comandos de DELETE
SQL
-- 1. DELETE: Cancelar a contratação do Artista 'Samba Raiz Forte' (ID 3).
-- NOTA: Como não há Apresentações ou Contratos ligados a ele, a exclusão direta é segura.
DELETE FROM Artista
WHERE ID_Artista = 3 AND Nome_Banda = 'Samba Raiz Forte';

-- 2. DELETE: Excluir uma Transação que falhou no processamento do pagamento (assumindo que falhou) e seus ingressos relacionados.
-- Excluir Transações com status 'Falha' ou 'Cancelada'. Aqui vamos excluir uma transação de exemplo (8001).
-- Atenção: Se houver restrições ON DELETE RESTRICT (padrão), os ingressos devem ser excluídos primeiro.

-- Primeiro, deletar os acessos e ingressos filhos da transação 8001 (RMTN006 e RMTN007)
DELETE FROM Acesso WHERE Codigo_Unico IN ('RMTN006'); 
DELETE FROM Ingresso WHERE ID_Transacao = 8001; 

-- Agora, deletar a transação pai
DELETE FROM Transacao 
WHERE ID_Transacao = 8001;

-- 3. DELETE: Remover um Palco temporário que não será usado no dia do evento (Palco Secundário 20).
-- ATENÇÃO: É necessário primeiro remover o Rider e a Apresentação (200) que dependem dele.
DELETE FROM Rider_Tecnico WHERE ID_Apresentacao = 200;
DELETE FROM Apresentacao WHERE ID_Palco = 20; 

DELETE FROM Palco
WHERE ID_Palco = 20;
