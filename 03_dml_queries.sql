SQL
  
-- 1. CONSULTA: Quais shows estão agendados para o Palco Principal?
SELECT 
    A.Nome_Banda,
    AP.Data_Hora_Inicio,
    P.Nome_Palco
FROM Apresentacao AP
JOIN Artista A ON AP.ID_Artista = A.ID_Artista
JOIN Palco P ON AP.ID_Palco = P.ID_Palco
WHERE P.Nome_Palco = 'Palco Principal - Rocha Viva'
ORDER BY AP.Data_Hora_Inicio;
2.2. Consulta de Agregação com GROUP BY
SQL

  
-- 2. CONSULTA: Qual o valor total arrecadado por Meio de Pagamento?
SELECT 
    Meio_Pagamento,
    COUNT(ID_Transacao) AS Num_Transacoes,
    SUM(Valor_Total) AS Total_Arrecadado
FROM Transacao
GROUP BY Meio_Pagamento
ORDER BY Total_Arrecadado DESC;
2.3. Consulta para Rastreamento de Ingresso (JOIN e Substring)
SQL

  
-- 3. CONSULTA: Detalhes dos ingressos da Transação 8000, incluindo o Lote e o nome do Comprador.
SELECT
    I.Codigo_Unico,
    I.Setor,
    L.Nome_Lote,
    L.Preco,
    C.Nome_Completo AS Nome_Comprador
FROM Ingresso I
JOIN Lote L ON I.ID_Lote = L.ID_Lote
JOIN Transacao T ON I.ID_Transacao = T.ID_Transacao
JOIN Comprador C ON T.ID_Comprador = C.ID_Comprador
WHERE I.ID_Transacao = 8000;
2.4. Consulta de Ocupação e Status (JOIN e Subconsulta)
SQL

  
-- 4. CONSULTA: Listar os ingressos que JÁ foram utilizados (check-in realizado).
SELECT
    I.Codigo_Unico,
    I.Setor,
    A.Horario_Entrada,
    A.Catraca_ID
FROM Ingresso I
JOIN Acesso A ON I.Codigo_Unico = A.Codigo_Unico
WHERE I.Status_Uso = 'Utilizado'
ORDER BY A.Horario_Entrada
LIMIT 5;
