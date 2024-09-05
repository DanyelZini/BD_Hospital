-- Active: 1718503894068@@127.0.0.1@3306@bd_hospital
-- Active: 1718503894068@@127.0.0.1@3306@hospital
-- SQLBook: Code


CREATE TABLE Departamento (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

CREATE TABLE Sala (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    tipo VARCHAR(8) NOT NULL,
    departamento_id INT NOT NULL,
    FOREIGN KEY(departamento_id) REFERENCES Departamento(id)
);

create table Medico (
    id INT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    telefone VARCHAR(13) NOT NULL,
    departamento_id INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(departamento_id) REFERENCES Departamento(id)
);

create table Paciente (
    id INT AUTO_INCREMENT NOT NULL ,
    nome VARCHAR(255) NOT NULL,
    rua VARCHAR(255),
    bairro VARCHAR(255),
    cidade VARCHAR(255),
    numero VARCHAR(255), 
    telefone VARCHAR(13),
    PRIMARY KEY(id)
 );

CREATE TABLE HorarioDeTrabalho (
    id INT AUTO_INCREMENT NOT NULL,
    medico_id INT NOT NULL,
    data DATE NOT NULL,
    turno VARCHAR(10),
    FOREIGN KEY(medico_id) REFERENCES Medico(id),
    PRIMARY KEY(id)
);

CREATE TABLE Atendimento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(8) NOT NULL,
    data DATE NOT NULL,
    hora INT NOT NULL,
    sala_id INT NOT NULL,
    medico_id INT NOT NULL,
    paciente_id INT NOT NULL,
    FOREIGN KEY(sala_id) REFERENCES Sala(id),
    FOREIGN KEY(medico_id) REFERENCES Medico(id),
    FOREIGN KEY(paciente_id) REFERENCES Paciente(id)
);

CREATE TABLE ResultadoDeExame (
    id INT AUTO_INCREMENT NOT NULL,
    atendimento_id INT NOT NULL,
    resultado TEXT NOT NULL,
    data DATE NOT NULL,
    FOREIGN KEY(atendimento_id) REFERENCES Atendimento(id),
    PRIMARY KEY(id)
);

CREATE TABLE Medicamento (
    id INT AUTO_INCREMENT NOT NULL,
    fornecedor_id INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    estoque INT NOT NULL,
    FOREIGN KEY(fornecedor_id) REFERENCES Fornecedor(id),
    PRIMARY KEY(id)
);

CREATE TABLE Receita (
    id INT AUTO_INCREMENT NOT NULL,
    atendimento_id INT NOT NULL,
    observacoes TEXT,
    FOREIGN KEY(atendimento_id) REFERENCES Atendimento(id),
    PRIMARY KEY(id)
);

CREATE TABLE Medicamentos (
    receita_id INT NOT NULL,
    medicamento_id INT NOT NULL,
    quantidade INT NOT NULL,
    Entregue BOOLEAN DEFAULT FALSE,
    FOREIGN KEY(receita_id) REFERENCES Receita(id),
    FOREIGN KEY(medicamento_id) REFERENCES Medicamento(id)
);

CREATE TABLE HistoricoDeInternacao (
    id INT AUTO_INCREMENT NOT NULL,
    paciente_id INT NOT NULL,
    sala_id INT NOT NULL,
    data DATE NOT NULL,
    FOREIGN KEY(paciente_id) REFERENCES Paciente(id),
    FOREIGN KEY(sala_id) REFERENCES Sala(id),
    PRIMARY KEY(id)
);

CREATE TABLE Fornecedor (
    id INT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE ControleEstoque (
    receita_id INT NOT NULL,
    medicamento_id INT NOT NULL,
    data DATE NOT NULL,
    FOREIGN KEY(receita_id) REFERENCES Receita(id),
    FOREIGN KEY(medicamento_id) REFERENCES Medicamento(id)
)


--------------------------------------------------------------------------------------
-- INSERÇÕES -------------------------------------------------------------------------
-- Inserção de 5 departamentos
INSERT INTO departamento (nome) VALUES
    ('Cardiologia'), 
    ('Neurologia'), 
    ('Ortopedia'), 
    ('Pediatria'), 
    ('Dermatologia');

-- Inserção de 10 salas 5 consultas e 5 cirurgias
INSERT INTO sala (tipo, departamento_id) VALUES
    ('Cirurgia', 1), ('Consulta', 1),
    ('Cirurgia', 2), ('Consulta', 2),
    ('Cirurgia', 3), ('Consulta', 3),
    ('Cirurgia', 4), ('Consulta', 4),
    ('Cirurgia', 5), ('Consulta', 5);

-- Inserção de 10 pacientes fictícios
INSERT INTO Paciente (nome, rua, bairro, cidade, numero, telefone)
VALUES
    ('Maria Silva', 'Rua A', 'Centro', 'São Paulo', '123', '1122334455'),
    ('João Oliveira', 'Rua B', 'Jardins', 'Rio de Janeiro', '456', '9988776655'),
    ('Ana Souza', 'Av. C', 'Copacabana', 'Rio de Janeiro', '789', '8877665544'),
    ('Pedro Santos', 'Rua D', 'Boa Vista', 'Porto Alegre', '101', '9988774433'),
    ('Luiza Pereira', 'Rua E', 'Barra', 'Salvador', '111', '9988771122'),
    ('Carlos Costa', 'Rua F', 'Ipanema', 'Rio de Janeiro', '222', '8877664433'),
    ('Mariana Almeida', 'Av. G', 'Centro', 'Belo Horizonte', '333', '9988772211'),
    ('Rafael Lima', 'Rua H', 'Lagoa', 'Rio de Janeiro', '444', '8877661122'),
    ('Juliana Ferreira', 'Rua I', 'Itaim', 'São Paulo', '555', '9988773344'),
    ('Fernando Oliveira', 'Av. J', 'Centro', 'Curitiba', '666', '8877667788');

-- Inserção de 10 médicos fictícios, cada um em um departamento diferente
INSERT INTO Medico (nome, telefone, departamento_id)
VALUES
    ('Dr. Carlos Mendes', '1122334455', 1),   -- Cardiologia
    ('Dra. Renata Costa', '9988776655', 2),   -- Neurologia
    ('Dr. Marcos Santos', '8877665544', 3),   -- Ortopedia
    ('Dra. Marina Oliveira', '9988774433', 4), -- Pediatria
    ('Dr. Pedro Almeida', '9988771122', 5),   -- Dermatologia
    ('Dra. Fernanda Lima', '8877664433', 1),  -- Cardiologia
    ('Dr. Gabriel Souza', '9988772211', 2),   -- Neurologia
    ('Dra. Carla Costa', '8877661122', 3),    -- Ortopedia
    ('Dr. Gustavo Silva', '9988773344', 4),   -- Pediatria
    ('Dra. Amanda Pereira', '8877667788', 5); -- Dermatologia

INSERT INTO Medicamento (nome, fornecedor_id, estoque) 
VALUES 
    ('Paracetamol', 1, 100),
    ('Amoxicilina', 2, 50),
    ('Ibuprofeno', 3, 75),
    ('Omeprazol', 4, 120),
    ('Metformina', 5, 90),
    ('Atorvastatina', 6, 60),
    ('Losartana', 7, 80),
    ('Aspirina', 8, 200),
    ('Metoprolol', 9, 110),
    ('Captopril', 10, 130);


-- Assumindo que já existam atendimentos com ids 1 a 10
INSERT INTO Receita (atendimento_id, observacoes) VALUES 
(1, 'Tomar após as refeições'),
(2, 'Uso contínuo'),
(3, 'Tomar antes de dormir'),
(4, 'Apenas em caso de dor');

-- Assumindo que as receitas são de ids 1 a 10 e medicamentos são de ids 1 a 10
INSERT INTO Medicamentos (receita_id, medicamento_id, quantidade) VALUES 
(1, 1, 2),
(1, 2, 1),
(2, 3, 3),
(2, 4, 1),
(3, 5, 2),
(4, 6, 1);

-- Assumindo que já existam pacientes com ids 1 a 10 e salas com ids 1 a 5
INSERT INTO HistoricoDeInternacao (paciente_id, sala_id, data) VALUES 
(1, 1, '2024-01-15'),
(2, 2, '2024-02-10'),
(3, 3, '2024-03-05'),
(4, 4, '2024-04-20'),
(5, 5, '2024-05-18'),
(6, 1, '2024-06-22'),
(7, 2, '2024-07-14'),
(8, 3, '2024-08-03'),
(9, 4, '2024-09-11'),
(10, 5, '2024-10-09');

INSERT INTO Fornecedor (nome) VALUES 
('Farmaceutica XYZ'),
('Distribuidora ABC'),
('Medicamentos Gerais Ltda'),
('Saúde e Vida S.A.'),
('Fornecedora Médica'),
('Remédios do Brasil'),
('Farmacêutica Global'),
('MedDistribuição'),
('Distribuidora Farma'),
('Saúde Total');





-- SELECT id FROM sala WHERE departamento_id = (SELECT id FROM departamento WHERE nome = 'Ortopedia') AND tipo = 'Consulta';
-- SELECT id FROM departamento WHERE nome = 'Pediatria';

-- SELECT COUNT(*) FROM sala 
--             WHERE departamento_id = 
--                 (SELECT id FROM departamento WHERE nome = 'Pediatria') AND tipo = 'Consulta';

-- SELECT COUNT(*) FROM sala;
-- SELECT id FROM sala WHERE departamento_id = 3 AND tipo = 'Consulta' ORDER BY id ASC LIMIT 1 OFFSET 1;

-- SELECT M.id, H.data, H.turno FROM medico M INNER JOIN horariodetrabalho H ON M.id = H.id WHERE M.departamento_id = 3;
-- SELECT A.* FROM atendimento A INNER JOIN (SELECT M.id, H.data, H.turno FROM medico M INNER JOIN horariodetrabalho H ON M.id = H.medico_id) P ON A.data = P.data;


-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCAO AGENDAMENTO TESTES ------------------------------------------------------------------------------------------------------------
-- Um paciente agenda uma consulta, o sistema verifica a disponibilidade do médico e da sala de consulta antes de efetivar a consulta. --

SELECT id FROM departamento WHERE nome = 'Pediatria';
SELECT id FROM sala WHERE tipo = 'Consulta';

SELECT s.id FROM departamento d INNER JOIN sala s on s.departamento_id = d.id WHERE s.tipo = 'Consulta' AND d.nome = 'Pediatria' ORDER BY id ASC LIMIT 1 OFFSET 0;

SELECT * FROM medico m INNER JOIN horariodetrabalho h ON 
SELECT COUNT(*) FROM departamento d INNER JOIN sala s on s.departamento_id = d.id WHERE s.tipo = 'Consulta' AND d.nome = 'Pediatria';

SELECT m.id FROM (SELECT id FROM medico WHERE departamento_id = 3) m INNER JOIN horariodetrabalho h ON h.medico_id = m.id WHERE h.data = '2024-07-07' AND h.turno = 'Tarde';
SELECT m.nome FROM medico m INNER JOIN horariodetrabalho h ON h.medico_id = m.id WHERE m.departamento_id = 2 AND h.data = '2024-07-06' AND h.turno = 'Manhã'

SELECT id FROM sala WHERE tipo = 'Consulta' AND departamento_id = 2;

--------------------------------------------------------------------------------------
-- FUNCAO AGENDAMENTO CONSULTA -------------------------------------------------------
-- FEITO -----------------------------------------------------------------------------
DELIMITER //
CREATE FUNCTION agendamento_consulta (
    IdPaciente INT,
    Departamento VARCHAR(255),
    CData DATE,
    CHora INT
)
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
    DECLARE departamentoId INT;
    DECLARE medicoId INT;
    DECLARE CTurno VARCHAR(5);
    DECLARE salaId INT;

    -- Definindo o turno
    IF (CHora >= 0 AND CHora < 12) THEN
        SET CTurno = 'Manhã';
    ELSE
        SET CTurno = 'Tarde';
    END IF;

    -- Obtendo o ID do departamento
    SELECT id INTO departamentoId FROM departamento WHERE nome = Departamento;

    IF EXISTS (SELECT 1 FROM atendimento WHERE data = CData AND hora = CHora) THEN
        RETURN 'Escolha outra data ou hora para sua consulta';
    ELSE 
        IF EXISTS (SELECT 1 FROM medico m INNER JOIN horariodetrabalho h ON h.medico_id = m.id WHERE m.departamento_id = departamentoId AND h.data = CData AND h.turno = CTurno) THEN
            SELECT m.id INTO medicoId FROM medico m INNER JOIN horariodetrabalho h ON h.medico_id = m.id WHERE m.departamento_id = departamentoId AND h.data = CData AND h.turno = CTurno LIMIT 1;
        ELSE
            RETURN 'Nenhum médico disponível para o turno e data especificados';
        END IF;
    END IF;

    -- Obtendo o ID da sala
    SELECT id INTO salaId FROM sala WHERE tipo = 'Consulta' AND departamento_id = departamentoId LIMIT 1;
    IF salaId IS NULL THEN
        RETURN 'Nenhuma sala disponível para o departamento especificado';
    END IF;

    -- Inserindo o atendimento
    INSERT INTO atendimento(tipo, data, hora, sala_id, medico_id, paciente_id) 
    VALUES ('Consulta', CData, CHora, salaId, medicoId, IdPaciente);

    RETURN 'Consulta agendada com sucesso';

END//
DELIMITER ;

-- Paciente id 3 inserido com sucesso
SELECT agendamento_consulta(3, 'Neurologia', '2024-07-06', 8);

-- Paciente id 4 falha, devese escolher outro horario
SELECT agendamento_consulta(4, 'Neurologia', '2024-07-06', 8);

-- Paciente id 4 mudou somente a hora, inserido com sucesso
SELECT agendamento_consulta(4, 'Neurologia', '2024-07-06', 9);

--------------------------------------------------------------------------------------
-- FUNCAO AGENDAMENTO CIRURGIA TESTE -------------------------------------------------
-- Um médico reserva uma sala para uma cirurgia, garantindo que não haja conflito de agendamento.
SELECT * FROM horariodetrabalho WHERE medico_id = 2 AND data = '2024-07-06' AND turno = 'Manhã';

SELECT id FROM departamento d INNER JOIN medico m ON m.departamento_id = d.id;

SELECT d.id FROM departamento d INNER JOIN medico m ON d.id = m.departamento_id WHERE m.id = 8;

--------------------------------------------------------------------------------------
-- FUNCAO AGENDAMENTO CIRURGIA -------------------------------------------------------
-- FEITO -----------------------------------------------------------------------------
DELIMITER //
CREATE FUNCTION agendamento_cirurgia (
    IdPaciente INT,
    IdMedico INT,
    CData DATE,
    CHora INT
)
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
    DECLARE departamentoId INT;
    DECLARE CTurno VARCHAR(5);
    DECLARE salaId INT;

    -- Definindo o turno
    IF (CHora >= 0 AND CHora < 12) THEN
        SET CTurno = 'Manhã';
    ELSE
        SET CTurno = 'Tarde';
    END IF;

    -- Obtendo o ID do departamento
    SELECT d.id INTO departamentoId FROM departamento d INNER JOIN medico m ON d.id = m.departamento_id WHERE m.id = IdMedico;

    IF EXISTS (SELECT 1 FROM atendimento WHERE data = CData AND hora = CHora) THEN
        RETURN 'Escolha outra data ou hora para sua consulta';
    ELSE 
        IF NOT EXISTS (SELECT 1 FROM horariodetrabalho WHERE medico_id = IdMedico AND data = CData AND turno = CTurno) THEN
            RETURN 'Turno do medico indisponivel';
        END IF;
    END IF;

    -- Obtendo o ID da sala
    SELECT id INTO salaId FROM sala WHERE tipo = 'Cirurgia' AND departamento_id = departamentoId LIMIT 1;
    IF salaId IS NULL THEN
        RETURN 'Nenhuma sala disponível para o departamento especificado';
    END IF;

    -- Inserindo o atendimento
    INSERT INTO atendimento(tipo, data, hora, sala_id, medico_id, paciente_id) 
    VALUES ('Cirurgia', CData, CHora, salaId, IdMedico, IdPaciente);

    RETURN 'Cirurgia agendada com sucesso';

END//
DELIMITER ;

-- Cirurgia do paciente id 5 inserida com sucesso --
SELECT agendamento_cirurgia(5, 8, '2024-07-14', 14) AS resultado;


-- Cirurgia do paciente id 6 falha, devese escolher outro horario --
SELECT agendamento_cirurgia(6, 8, '2024-07-14', 14) AS resultado;


--Cirurgia do paciente id 6 inserida com sucesso --
SELECT agendamento_cirurgia(6, 8, '2024-07-14', 15) AS resultado;

--------------------------------------------------------------------------------------
-- FUNCAO ADMINISTRACAO DE MEDICAMENTOS TESTE-----------------------------------------
-- Registra a administração de medicamentos a um paciente, atualizando os estoques. Medicamentos com estoques baixos podem gerar alertas.
SELECT COUNT(*) FROM receita r INNER JOIN medicamentos m ON r.id = (m.receita_id = 2);
SELECT COUNT(*) FROM medicamentos WHERE receita_id = 2 AND Entregue = FALSE;
SELECT m.medicamento_id, m.quantidade FROM receita r INNER JOIN medicamentos m ON r.id = (m.receita_id = 2) WHERE m.Entregue = FALSE;
SELECT m.medicamento_id, m.quantidade FROM receita r INNER JOIN medicamentos m ON r.id = (m.receita_id = 2) LIMIT 1 OFFSET 0;

UPDATE medicamento SET estoque = estoque - 5 WHERE id = 3;

--------------------------------------------------------------------------------------
-- FUNCAO ADMINISTRACAO DE MEDICAMENTOS ----------------------------------------------
-- FEITO -----------------------------------------------------------------------------
DELIMITER //
CREATE FUNCTION administracao_medicamentos_receita (
    IdReceita INT
) 
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
    DECLARE QuantRes INT;
    DECLARE MedId INT;
    DECLARE QuantMed INT;
    DECLARE EstoqMed INT;
    DECLARE EstoqBai BOOLEAN DEFAULT FALSE;
    DECLARE i INT DEFAULT 0;

    SELECT COUNT(*) INTO QuantRes FROM medicamentos WHERE receita_id = IdReceita AND Entregue = FALSE;
    IF QuantRes = 0 THEN
        RETURN 'Todos os medicamentos ja foram entregues, ou nao ha medicamentos na receita';
    END IF;

    WHILE i < QuantRes DO
        SELECT m.medicamento_id, m.quantidade INTO MedId, QuantMed FROM medicamentos m WHERE m.receita_id = IdReceita AND m.Entregue = FALSE LIMIT 1 OFFSET i;

        SELECT estoque INTO EstoqMed FROM medicamento WHERE id = MedId;

        IF EstoqMed - QuantMed < 0 THEN
            RETURN 'Estoque insuficiente';
        ELSE
            IF EstoqMed - QuantMed <= 10 THEN
                SET EstoqBai = TRUE;
            END IF;
            UPDATE medicamento SET estoque = estoque - QuantMed WHERE id = MedId;
            UPDATE medicamentos SET Entregue = TRUE WHERE receita_id = IdReceita AND medicamento_id = MedId;
            INSERT INTO controleestoque (receita_id, medicamento_id, data) VALUES (IdReceita, MedId, DATE_ADD(CURDATE(), INTERVAL 0  DAY));
        END IF;

        SET i = i + 1;
    END WHILE;

    IF EstoqBai THEN
        RETURN 'Baixo estoque de medicamentos, relatório e medicamentos entregues com sucesso';
    ELSE
        RETURN 'Medicamentos e relatório entregues com sucesso';
    END IF;
END //
DELIMITER ;

SELECT administracao_medicamentos_receita(2);

--------------------------------------------------------------------------------------
-- FUNCAO CONTROLE DE ESTOQUE TESTE --------------------------------------------------
-- Registra a entrada e saída de medicamentos e insumos médicos, atualizando os estoques conforme as transações.











--------------------------------------------------------------------------------------
-- FUNCAO CONTROLE DE ESTOQUE --------------------------------------------------------
-- FEITO -----------------------------------------------------------------------------













--------------------------------------------------------------------------------------
-- FUNCAO RELATORIO DE DESEMPENHO TESTE ----------------------------------------------
-- Calcula métricas como o número de consultas realizadas por médico em um período específico.












--------------------------------------------------------------------------------------
-- FUNCAO RELATORIO DE DESEMPENHO ----------------------------------------------------
-- FEITO -----------------------------------------------------------------------------













--------------------------------------------------------------------------------------
-- Inserir Horarios dos medicos alternados -------------------------------------------
DELIMITER //
CREATE PROCEDURE InserirHorariosAlternados()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE medico_id INT;
    DECLARE data_inicio DATE;
    DECLARE turno VARCHAR(10);

    DECLARE quant_medico INT;
    SELECT COUNT(*) INTO quant_medico FROM Medico;

    SET data_inicio = CURDATE();
    
    WHILE i <= quant_medico DO
        SET medico_id = (SELECT id FROM Medico WHERE id = i);

        IF i % 2 = 0 THEN
            INSERT INTO HorarioDeTrabalho (medico_id, data, turno)
            VALUES (medico_id, DATE_ADD(data_inicio, INTERVAL i DAY), 'Manhã');

            INSERT INTO HorarioDeTrabalho (medico_id, data, turno)
            VALUES (medico_id, DATE_ADD(data_inicio, INTERVAL i + 2 DAY), 'Tarde');
        ELSE
            INSERT INTO HorarioDeTrabalho (medico_id, data, turno)
            VALUES (medico_id, DATE_ADD(data_inicio, INTERVAL i DAY), 'Tarde');

            INSERT INTO HorarioDeTrabalho (medico_id, data, turno)
            VALUES (medico_id, DATE_ADD(data_inicio, INTERVAL i + 2 DAY), 'Manhã');

        END IF;
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;
CALL InserirHorariosAlternados();
--------------------------------------------------------------------------------------
