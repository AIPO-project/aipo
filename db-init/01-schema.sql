-- AIPO: inicializacao idempotente do esquema (MySQL 8.0+)
-- Execute com usuario autorizado a criar o banco e as tabelas.
-- ATENCAO: IF NOT EXISTS nao atualiza estruturas ja existentes.
CREATE DATABASE IF NOT EXISTS `aipo`
  CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `aipo`;

CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `matricula` varchar(45) NOT NULL,
  `tipoUsuario` varchar(45) DEFAULT NULL,
  `nivelGerencia` varchar(45) DEFAULT NULL,
  `chave` varchar(45) DEFAULT NULL,
  `ativo` tinyint DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `matricula_UNIQUE` (`matricula`),
  UNIQUE KEY `chave_UNIQUE` (`chave`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `salas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) DEFAULT NULL,
  `codigo` varchar(45) DEFAULT NULL,
  `fechadura` varchar(45) NOT NULL,
  `local` varchar(45) DEFAULT NULL,
  `ativo` tinyint DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `fechadura_UNIQUE` (`fechadura`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `autorizacao` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_sala` int NOT NULL,
  `data_limite` datetime DEFAULT NULL,
  `data_inicio` datetime DEFAULT NULL,
  `horario_inicio` time DEFAULT NULL,
  `horario_fim` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_teste_1_idx` (`id_usuario`),
  KEY `fk_teste_2_idx` (`id_sala`),
  CONSTRAINT `fk_teste_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_teste_2` FOREIGN KEY (`id_sala`) REFERENCES `salas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `acessos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `usuario` varchar(45) NOT NULL,
  `sala` int NOT NULL,
  `timestamp` datetime NOT NULL,
  `autorizado` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_acessos_1_idx` (`usuario`),
  KEY `fk_acessos_2_idx` (`sala`),
  CONSTRAINT `fk_acessos_1` FOREIGN KEY (`usuario`) REFERENCES `usuarios` (`matricula`) ON UPDATE CASCADE,
  CONSTRAINT `fk_acessos_2` FOREIGN KEY (`sala`) REFERENCES `salas` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;