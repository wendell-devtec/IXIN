-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Tempo de geração: 05/06/2023 às 22:35
-- Versão do servidor: 10.5.19-MariaDB-cll-lve
-- Versão do PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `u694995905_ixxin`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `avisos`
--

CREATE TABLE `avisos` (
  `id` int(11) NOT NULL,
  `mensagem` varchar(500) NOT NULL,
  `data` varchar(10) NOT NULL,
  `dataF` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `avisos`
--

INSERT INTO `avisos` (`id`, `mensagem`, `data`, `dataF`) VALUES
(1, 'REUNIAO DIA 05/03/2024', '19/04/2023', '24/04/2023'),
(2, 'DIA 05/03/2024', '26/09/1990', '19/04/2023'),
(3, 'REUNIAO DIA 05/03/2024', '18/04/2023', '18/04/2023'),
(4, 'REUNIAO DIA 05/03/2024', '19/04/2023', '30/04/2023'),
(5, 'DIA 05/03/2024', '26/09/1990', '30/04/2023'),
(6, 'REUNIAO DIA 05/03/2024', '18/04/2023', '30/04/2023');

-- --------------------------------------------------------

--
-- Estrutura para tabela `close`
--

CREATE TABLE `close` (
  `id` int(11) NOT NULL,
  `loja` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `luz` varchar(3) NOT NULL,
  `ar` varchar(3) NOT NULL,
  `data` varchar(10) NOT NULL,
  `cell` varchar(3) NOT NULL,
  `pc` varchar(3) NOT NULL,
  `cx` varchar(3) NOT NULL,
  `retaguarda` varchar(10) NOT NULL,
  `obs` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `close`
--

INSERT INTO `close` (`id`, `loja`, `nome`, `luz`, `ar`, `data`, `cell`, `pc`, `cx`, `retaguarda`, `obs`) VALUES
(1, 650, '11', '21/', 'NÃO', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', 'TESTE'),
(2, 650, '11', '21/', 'NÃO', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', 'TESTE'),
(3, 650, '11', '21/', 'NÃO', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', 'null'),
(4, 456, '11', '21/', 'NÃO', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', ''),
(5, 456, '11', '21/', 'NÃO', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', 'Teste'),
(6, 456, '11', '21/', 'SIM', 'SIM', 'SIM', 'SIM', 'SIM', '', 'Teste'),
(7, 456, '11', '21/', 'SIM', 'SIM', 'SIM', 'SIM', 'SIM', '', 'Teste'),
(8, 11, '456 JOSE PEDRO', '21/', 'SIM', 'SIM', 'SIM', 'SIM', 'SIM', '', 'Teste'),
(9, 11, '456 JOSE PEDRO', 'SIM', 'SIM', '21/04/2023', 'SIM', 'SIM', 'SIM', '', 'Teste'),
(10, 11, '650 JOSE PEDRO ANDRADE', 'SIM', 'SIM', '22/04/2023', 'SIM', 'SIM', 'SIM', '', ''),
(11, 11, '456 JOSE PEDRO', 'SIM', 'SIM', '27/04/2023', 'SIM', 'SIM', 'SIM', '5679', 'Lâmpada queimada'),
(12, 11, '650 JOSE PEDRO ANDRADE', 'SIM', 'SIM', '29/04/2023', 'NÃO', 'SIM', 'SIM', '', ''),
(13, 11, '456 JOSE PEDRO', 'NÃO', 'NÃO', '17/05/2023', 'SIM', 'SIM', 'SIM', '89', '');

-- --------------------------------------------------------

--
-- Estrutura para tabela `encomenda_clientes`
--

CREATE TABLE `encomenda_clientes` (
  `id` int(11) NOT NULL,
  `nomeP` varchar(100) NOT NULL,
  `loja` int(10) NOT NULL,
  `vendedor` varchar(100) NOT NULL,
  `data` varchar(20) NOT NULL,
  `status` varchar(50) NOT NULL,
  `sinal` varchar(5) NOT NULL,
  `valor_sinal` int(10) NOT NULL,
  `obs` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `encomenda_clientes`
--

INSERT INTO `encomenda_clientes` (`id`, `nomeP`, `loja`, `vendedor`, `data`, `status`, `sinal`, `valor_sinal`, `obs`) VALUES
(1, 'COMPUTADODOR', 11, '56 - JOSE', '25/09/1990', 'Recebido - OK', 'true', 678, ''),
(5, 'IUI', 0, '', '', '', '', 0, ''),
(6, 'dfg', 0, '', '', '', '', 0, ''),
(7, 'cv', 11, '', '', '', '', 0, ''),
(8, 'dfb', 9, '', '', '', '', 0, ''),
(9, 'wendell', 11, '19 iara', '16/04/2023', 'Pendente', 'true', 258, ''),
(10, 'nagag', 11, '25 carla', '16/04/2023', 'Pendente', 'true', 58, ''),
(11, 'sbbs', 11, 'Jose carlo 258', '16/04/2023', 'Pendente', 'true', 258, ''),
(12, 'qvahd', 11, '25 - Antônio', '16/04/2023', 'Pendente', 'true', 258, '258'),
(13, '', 11, '', '22/04/2023', 'Pendente', 'false', 0, ''),
(14, '', 11, '', '22/04/2023', 'Pendente', 'false', 0, ''),
(15, '', 11, '', '22/04/2023', 'Pendente', 'false', 0, ''),
(16, '', 11, '', '22/04/2023', 'Pendente', 'false', 0, ''),
(17, '', 11, '', '22/04/2023', 'Pendente', 'false', 0, ''),
(18, 'ssc', 11, '2456', '22/04/2023', 'Pendente', 'true', 567, 'sdv'),
(19, 'Ssd 256gb', 11, '50- Cláudio', '27/04/2023', 'Pendente', 'true', 567, ''),
(20, 'Tet', 11, '456 JOSE PEDRO', '29/04/2023 20:26:28', 'RETIRADO PELO CLIENTE', 'true', 678, 'sfg');

-- --------------------------------------------------------

--
-- Estrutura para tabela `login`
--

CREATE TABLE `login` (
  `id` int(11) NOT NULL,
  `user` varchar(10) NOT NULL,
  `pass` varchar(20) NOT NULL,
  `loja` int(11) NOT NULL,
  `latitude` varchar(50) NOT NULL,
  `longitude` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `login`
--

INSERT INTO `login` (`id`, `user`, `pass`, `loja`, `latitude`, `longitude`) VALUES
(1, '1', '1', 11, '-23.66389', '-46.4969467');

-- --------------------------------------------------------

--
-- Estrutura para tabela `loja`
--

CREATE TABLE `loja` (
  `id` int(11) NOT NULL,
  `nome` varchar(30) NOT NULL,
  `latitude` varchar(50) NOT NULL,
  `longitude` varchar(50) NOT NULL,
  `numero` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `loja`
--

INSERT INTO `loja` (`id`, `nome`, `latitude`, `longitude`, `numero`) VALUES
(1, 'LOJA 01', '-23.66389', '-46.4969467', 11),
(2, 'LOJA 02', '-23.7069888', '-46.4969467', 5);

-- --------------------------------------------------------

--
-- Estrutura para tabela `motoboy`
--

CREATE TABLE `motoboy` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `ativo` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `motoboy`
--

INSERT INTO `motoboy` (`id`, `nome`, `ativo`) VALUES
(1, 'JOSE', 'ATIVO'),
(2, 'PEDRO', 'ATIVO'),
(3, 'CLEITON', 'ATIVO');

-- --------------------------------------------------------

--
-- Estrutura para tabela `open`
--

CREATE TABLE `open` (
  `id` int(11) NOT NULL,
  `loja` int(10) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `data` varchar(10) NOT NULL,
  `obs` varchar(500) NOT NULL,
  `luz` varchar(5) NOT NULL,
  `ar` varchar(5) NOT NULL,
  `celular` varchar(5) NOT NULL,
  `caixa` varchar(5) NOT NULL,
  `computador` varchar(5) NOT NULL,
  `tv` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `open`
--

INSERT INTO `open` (`id`, `loja`, `nome`, `data`, `obs`, `luz`, `ar`, `celular`, `caixa`, `computador`, `tv`) VALUES
(1, 11, '650 JOSE PEDRO ANDRADE', '21/04/2023', 'Pc quebrado', 'tru', 'tru', 'tru', 'tru', 'tru', '0'),
(2, 11, '650 JOSE PEDRO ANDRADE', '21/04/2023', 'Pc quebrado', 'tru', 'tru', 'tru', 'tru', 'tru', '0'),
(3, 11, '650 JOSE PEDRO ANDRADE', '21/04/2023', 'Pc quebrado', 'tru', 'tru', 'tru', 'tru', 'tru', '0'),
(4, 11, '650 JOSE PEDRO ANDRADE', '21/04/2023', 'Pc quebrado', 'true', 'true', 'true', 'true', 'true', 'false'),
(5, 11, '', '21/04/2023', '', 'SIM', 'SIM', 'SIM', 'SIM', 'SIM', 'SIM'),
(6, 11, '', '21/04/2023', '', 'SIM', 'SIM', 'SIM', 'SIM', 'SIM', 'SIM'),
(7, 11, '650 JOSE PEDRO ANDRADE', '22/04/2023', '', 'true', 'true', 'true', 'true', 'true', 'true'),
(8, 11, '650 JOSE PEDRO ANDRADE', '22/04/2023', '', 'true', 'true', 'true', 'true', 'true', 'true'),
(9, 11, '456 JOSE PEDRO', '22/04/2023', '', 'true', 'true', 'true', 'true', 'true', 'true'),
(10, 11, '650 JOSE PEDRO ANDRADE', '22/04/2023', 'comi uma bct', 'true', 'true', 'true', 'false', 'false', 'false'),
(11, 11, '456 JOSE PEDRO', '22/04/2023', '', 'false', 'true', 'true', 'false', 'true', 'true'),
(12, 11, '456 JOSE PEDRO', '22/04/2023', '', 'false', 'true', 'true', 'false', 'true', 'true'),
(13, 11, '456 JOSE PEDRO', '22/04/2023', '', 'true', 'true', 'true', 'true', 'true', 'true'),
(14, 11, '650 JOSE PEDRO ANDRADE', '22/04/2023', 'hgc', 'true', 'true', 'true', 'true', 'true', 'true'),
(15, 11, '650 JOSE PEDRO ANDRADE', '27/04/2023', '', 'true', 'true', 'true', 'true', 'true', 'true'),
(16, 11, '456 JOSE PEDRO', '29/04/2023', '', 'true', 'true', 'true', 'true', 'true', 'true'),
(17, 11, '456 JOSE PEDRO', '29/04/2023', '', 'true', 'true', 'true', 'true', 'true', 'true'),
(18, 11, '650 JOSE PEDRO ANDRADE', '17/05/2023', 'porta destrancada', 'true', 'true', 'true', 'true', 'true', 'true');

-- --------------------------------------------------------

--
-- Estrutura para tabela `ordem_servico`
--

CREATE TABLE `ordem_servico` (
  `id` int(11) NOT NULL,
  `loja` int(11) NOT NULL,
  `data` varchar(20) NOT NULL,
  `os_number` int(11) NOT NULL,
  `produto` varchar(50) NOT NULL,
  `vendedor` varchar(100) NOT NULL,
  `status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `ordem_servico`
--

INSERT INTO `ordem_servico` (`id`, `loja`, `data`, `os_number`, `produto`, `vendedor`, `status`) VALUES
(1, 11, '25/09/1990', 1987, 'celular', '890 - pedro felipe', 'AGUARDANDO'),
(2, 11, '25/09/1991', 1988, 'celul rar', '890 - pedro felipe', 'RETIRADO'),
(3, 11, '', 0, '', '', ''),
(4, 11, '', 0, '', '', ''),
(5, 11, '29/04/2023 21:35:43', 0, '', '', ''),
(6, 11, '29/04/2023 21:37:15', 1992, 'Notebook', '', ''),
(7, 11, '29/04/2023 21:39:08', 1993, 'Celular', '', ''),
(8, 11, '29/04/2023 21:40:32', 1994, 'Notebook', '', ''),
(9, 11, '29/04/2023 21:41:34', 1995, 'Notebook', '456 -  JOSE PEDRO', ''),
(10, 11, '29/04/2023 21:43:16', 1996, 'Notebook', '456 -  JOSE PEDRO', 'RETIRADO'),
(11, 11, '30/04/2023 23:41:19', 1997, 'Notebook', '456 JOSE PEDRO', 'AGUARDANDO SETOR'),
(12, 11, '17/05/2023 11:25:15', 1998, 'Notebook', '650 JOSE PEDRO ANDRADE', 'AGUARDANDO SETOR');

-- --------------------------------------------------------

--
-- Estrutura para tabela `ouvidoria`
--

CREATE TABLE `ouvidoria` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `sac_text` text NOT NULL,
  `data` varchar(19) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `ouvidoria`
--

INSERT INTO `ouvidoria` (`id`, `nome`, `sac_text`, `data`) VALUES
(1, 'fasas', 'fazfas', ''),
(2, 'sdc', '', ''),
(3, 'wendell', '', ''),
(4, 'Junior ', 'Olá tudo bem', ''),
(5, 'scv', 'wsfvb', '15/04/2023'),
(6, 'wendell ', 'wwndrg', '15/04/2023 21:05:23'),
(7, 'Junior ', 'verificar folga no meio da semana para os colaboradores ', '27/04/2023 15:24:19'),
(8, 'te', 'sgd', '29/04/2023');

-- --------------------------------------------------------

--
-- Estrutura para tabela `produtos`
--

CREATE TABLE `produtos` (
  `id` int(11) NOT NULL,
  `nome` varchar(500) NOT NULL,
  `code` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `produtos`
--

INSERT INTO `produtos` (`id`, `nome`, `code`) VALUES
(1, 'CELULAR NOTE 11', 98766),
(2, 'CELULAR NOTE 10S', 56);

-- --------------------------------------------------------

--
-- Estrutura para tabela `ranking`
--

CREATE TABLE `ranking` (
  `id` int(11) NOT NULL,
  `seller` varchar(50) NOT NULL,
  `google` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `rota_motoboy`
--

CREATE TABLE `rota_motoboy` (
  `id` int(11) NOT NULL,
  `dataC` varchar(20) NOT NULL,
  `dataS` varchar(20) NOT NULL,
  `local_last` varchar(20) NOT NULL,
  `local_next` varchar(20) NOT NULL,
  `loja` int(10) NOT NULL,
  `motoboy` varchar(50) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `produtos` varchar(20) NOT NULL,
  `malote` varchar(20) NOT NULL,
  `troco` varchar(20) NOT NULL,
  `os` varchar(20) NOT NULL,
  `outros` varchar(500) NOT NULL,
  `produtosL` varchar(3) NOT NULL,
  `maloteL` varchar(3) NOT NULL,
  `osL` varchar(3) NOT NULL,
  `trocoL` varchar(3) NOT NULL,
  `outrosL` varchar(500) NOT NULL,
  `lat_now` varchar(50) NOT NULL,
  `long_now` varchar(50) NOT NULL,
  `lat_next` varchar(50) NOT NULL,
  `long_next` varchar(50) NOT NULL,
  `distancia` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `rota_motoboy`
--

INSERT INTO `rota_motoboy` (`id`, `dataC`, `dataS`, `local_last`, `local_next`, `loja`, `motoboy`, `nome`, `produtos`, `malote`, `troco`, `os`, `outros`, `produtosL`, `maloteL`, `osL`, `trocoL`, `outrosL`, `lat_now`, `long_now`, `lat_next`, `long_next`, `distancia`) VALUES
(24, '18:16:09', '22/04/2023 17:53:55', 'LOJA 02', 'LOJA 01', 11, 'JOSE', '650 JOSE PEDRO ANDRADE', 'SIM', 'SIM', 'SIM', 'SIM', '', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', '', '', '', '', ''),
(25, '18:23:46', '22/04/2023 17:55:55', 'LOJA 01', 'LOJA 02', 11, 'JOSE', '650 JOSE PEDRO ANDRADE', 'SIM', 'SIM', 'SIM', 'SIM', '', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', '', '', '', '', ''),
(26, '22/04/2023 18:54:00', '22/04/2023 18:54:13', 'LOJA 01', 'LOJA 02', 11, 'JOSE', '456 JOSE PEDRO', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', '', '', '', '', ''),
(27, '22/04/2023 18:54:29', '22/04/2023 18:54:41', 'LOJA 02', 'LOJA 02', 11, 'PEDRO', '650 JOSE PEDRO ANDRADE', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', '', '', '', '', ''),
(28, '22/04/2023 18:57:05', '22/04/2023 18:57:18', 'LOJA 02', 'LOJA 02', 11, 'CLEITON', '456 JOSE PEDRO', 'SIM', 'SIM', 'SIM', 'SIM', '', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', '', '', '', '', ''),
(29, '23/04/2023 12:09:19', '23/04/2023 12:10:01', 'LOJA 01', 'LOJA 01', 11, 'CLEITON', '456 JOSE PEDRO', 'NÃO', 'NÃO', 'NÃO', 'NÃO', 'tet', 'SIM', 'SIM', 'SIM', 'SIM', 'bsbd', '', '', '', '', ''),
(30, '23/04/2023 12:19:02', '23/04/2023 12:19:11', 'LOJA 01', 'LOJA 01', 11, 'CLEITON', '650 JOSE PEDRO ANDRADE', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', '', '', '', '', ''),
(31, '23/04/2023 17:51:02', '23/04/2023 17:52:00', 'LOJA 01', 'LOJA 02', 11, 'CLEITON', '456 JOSE PEDRO', 'SIM', 'SIM', 'SIM', 'SIM', '', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', '-23.66389', '-46.4969467', '-23.66389', '-23.66389', ''),
(32, '23/04/2023 18:00:45', '23/04/2023 18:01:12', 'LOJA 01', 'LOJA 02', 11, 'CLEITON', '650 JOSE PEDRO ANDRADE', 'SIM', 'SIM', 'SIM', 'SIM', '', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', '-23.66389', '-46.4969467', '-23.7069888', '-46.4969467', ''),
(33, '23/04/2023 20:00:24', '23/04/2023 20:01:04', 'LOJA 01', 'LOJA 02', 11, 'JOSE', '650 JOSE PEDRO ANDRADE', 'SIM', 'SIM', 'SIM', 'SIM', '', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', '-23.66389', '-46.4969467', '-23.7069888', '-46.4969467', ''),
(34, '23/04/2023 20:07:31', '23/04/2023 20:07:49', 'LOJA 01', 'LOJA 02', 11, 'CLEITON', '456 JOSE PEDRO', 'NÃO', 'NÃO', 'NÃO', 'SIM', '', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', '-23.66389', '-46.4969467', '-23.7069888', '-46.4969467', '89'),
(35, '23/04/2023 20:08:18', '23/04/2023 20:08:29', 'LOJA 01', 'LOJA 02', 11, 'JOSE', '456 JOSE PEDRO', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', '-23.66389', '-46.4969467', '-23.7069888', '-46.4969467', ''),
(36, '23/04/2023 20:09:53', '23/04/2023 20:10:11', 'LOJA 01', 'LOJA 02', 11, 'JOSE', '650 JOSE PEDRO ANDRADE', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', '-23.66389', '-46.4969467', '-23.7069888', '-46.4969467', ''),
(37, '23/04/2023 20:10:44', '23/04/2023 20:10:57', 'LOJA 01', 'LOJA 02', 11, 'PEDRO', '456 JOSE PEDRO', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', '-23.66389', '-46.4969467', '-23.7069888', '-46.4969467', ''),
(38, '23/04/2023 20:12:39', '23/04/2023 20:12:53', 'LOJA 01', 'LOJA 02', 11, 'PEDRO', '456 JOSE PEDRO', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', '-23.66389', '-46.4969467', '-23.7069888', '-46.4969467', ''),
(39, '23/04/2023 20:14:41', '23/04/2023 20:14:53', 'LOJA 01', 'LOJA 02', 11, 'CLEITON', '650 JOSE PEDRO ANDRADE', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', '-23.66389', '-46.4969467', '-23.7069888', '-46.4969467', ''),
(40, '23/04/2023 20:17:12', '23/04/2023 20:17:27', 'LOJA 02', 'LOJA 02', 11, 'JOSE', '650 JOSE PEDRO ANDRADE', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', '-23.66389', '-46.4969467', '-23.7069888', '-46.4969467', '7.1 Km'),
(41, '27/04/2023 15:21:47', '27/04/2023 15:22:11', 'LOJA 01', 'LOJA 02', 11, 'PEDRO', '650 JOSE PEDRO ANDRADE', 'SIM', 'SIM', 'SIM', 'NÃO', 'mkt', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', '-23.66389', '-46.4969467', '-23.7069888', '-46.4969467', '7.1 Km'),
(42, '29/04/2023 21:48:18', '29/04/2023 21:48:41', 'LOJA 02', 'LOJA 01', 11, 'CLEITON', '650 JOSE PEDRO ANDRADE', 'SIM', 'SIM', 'SIM', 'SIM', 'df', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', '-23.66389', '-46.4969467', '-23.66389', '-46.4969467', '0.0 Km'),
(43, '29/04/2023 21:57:53', '29/04/2023 21:58:04', 'LOJA 01', 'LOJA 02', 11, 'CLEITON', '456 JOSE PEDRO', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', '-23.66389', '-46.4969467', '-23.7069888', '-46.4969467', '7.1 Km'),
(44, '30/04/2023 14:34:04', '30/04/2023 14:34:20', 'LOJA 02', 'LOJA 01', 11, 'PEDRO', '456 JOSE PEDRO', 'SIM', 'SIM', 'SIM', 'SIM', 'df', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', '-23.66389', '-46.4969467', '-23.66389', '-46.4969467', '0.0 Km'),
(45, '30/04/2023 14:34:46', '30/04/2023 14:35:01', 'LOJA 01', 'LOJA 02', 11, 'PEDRO', '456 JOSE PEDRO', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', '-23.66389', '-46.4969467', '-23.7069888', '-46.4969467', '7.1 Km'),
(46, '30/04/2023 14:41:58', '30/04/2023 14:42:11', 'LOJA 01', 'LOJA 02', 11, 'JOSE', '456 JOSE PEDRO', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', '-23.66389', '-46.4969467', '-23.7069888', '-46.4969467', '7.1 Km'),
(47, '30/04/2023 14:45:21', '30/04/2023 14:45:33', 'LOJA 02', 'LOJA 02', 11, 'CLEITON', '456 JOSE PEDRO', 'SIM', 'SIM', 'SIM', 'SIM', '', 'NÃO', 'NÃO', 'NÃO', 'NÃO', '', '-23.66389', '-46.4969467', '-23.7069888', '-46.4969467', '7.1 Km');

-- --------------------------------------------------------

--
-- Estrutura para tabela `solicitacao_produtos`
--

CREATE TABLE `solicitacao_produtos` (
  `id` int(11) NOT NULL,
  `loja` int(10) NOT NULL,
  `nomeP` varchar(500) NOT NULL,
  `code` int(10) NOT NULL,
  `qtd` int(10) NOT NULL,
  `qtd_separed` int(11) NOT NULL,
  `vendedor` varchar(250) NOT NULL,
  `data` varchar(20) NOT NULL,
  `status` varchar(50) NOT NULL,
  `obs` varchar(500) NOT NULL,
  `recebido` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `solicitacao_produtos`
--

INSERT INTO `solicitacao_produtos` (`id`, `loja`, `nomeP`, `code`, `qtd`, `qtd_separed`, `vendedor`, `data`, `status`, `obs`, `recebido`) VALUES
(1, 11, 'CELULAR NOTE 11', 98766, 6, 0, '156 - gabriel', '17/04/2023', 'Recebido - OK', '5', ''),
(2, 11, 'CELULAR NOTE 11', 98766, 6, 0, '157 - gabriel', '17/04/2023', 'Recebido - OK', '5', ''),
(3, 11, 'CELULAR NOTE 11 Azul', 98766, 6, 0, '159 - gabriel', '18/04/2023', 'Recebido - OK', '5', ''),
(11, 11, 'CELULAR NOTE 11', 98766, 0, 0, '160 - gabriel', '19/04/2023', 'Recebido - OK', '', ''),
(12, 11, 'CELULAR NOTE 11', 98766, 0, 0, '156 - gabriel', '19/04/2023', 'Recebido - OK', '', ''),
(13, 11, 'CELULAR NOTE 11', 98766, 0, 0, '156 - gabriel', '19/04/2023 20:16:08', 'Recebido - OK', '', ''),
(14, 11, 'CELULAR NOTE 11', 98766, 0, 0, '156 - gabriel', '19/04/2023 20:16:08', 'Recebido - OK', '', ''),
(15, 11, 'CELULAR NOTE 11', 98766, 0, 0, '156 - gabriel', '19/04/2023 20:16:08', 'Recebido - OK', '', ''),
(16, 11, 'CELULAR NOTE 11', 98766, 0, 0, '156 - gabriel', '19/04/2023 20:16:08', 'Recebido - OK', '', ''),
(17, 11, 'SACO DE LIXO', 0, 0, 0, '', '19/04/2023', 'Recebido - OK', '', ''),
(18, 7, 'SACO DE LIXO', 0, 0, 0, '', '19/04/2023', 'AGUARDANDO SETOR', '', ''),
(19, 11, 'CELULAR NOTE 11', 98766, 6, 0, '156 - gabriel', '27/04/2023', 'Recebido - OK', '', ''),
(20, 11, 'CELULAR NOTE 10S', 56, 1, 0, '156 - gabriel', '27/04/2023', 'Recebido - OK', '', ''),
(21, 11, 'CELULAR NOTE 11', 98766, 12, 0, '156 - gabriel', '29/04/2023', 'Recebido - OK', '', ''),
(22, 11, 'CELULAR NOTE 10S', 56, 1, 0, '456 JOSE PEDRO', '29/04/2023', 'Recebido - OK', '', ''),
(23, 11, 'CELULAR NOTE 11', 98766, 0, 0, '456 JOSE PEDRO', '29/04/2023', 'Recebido - OK', '', ''),
(24, 11, 'CELULAR NOTE 11', 98766, 6, 0, '156 - gabriel', '30/04/2023', 'Recebido - OK', '', ''),
(25, 11, 'CELULAR NOTE 11', 98766, 6, 0, '156 - gabriel', '30/04/2023', 'Recebido - OK', '', ''),
(26, 11, 'CELULAR NOTE 10S', 56, 789, 0, '456 JOSE PEDRO', '30/04/2023', 'Recebido - OK', '', ''),
(27, 11, 'CELULAR NOTE 10S', 56, 0, 0, '456 JOSE PEDRO', '30/04/2023', 'Recebido - OK', '', ''),
(28, 11, 'CELULAR NOTE 11', 98766, 0, 0, '456 JOSE PEDRO', '30/04/2023', 'Recebido - OK', '', ''),
(29, 11, 'CELULAR NOTE 11', 98766, 1, 0, '156 - gabriel', '30/04/2023', 'Recebido - OK', '', ''),
(30, 11, 'CELULAR NOTE 11', 98766, 0, 0, '156 - gabriel', '30/04/2023', 'Recebido - OK', '', ''),
(31, 11, 'CELULAR NOTE 11', 98766, 0, 0, '156 - gabriel', '30/04/2023', 'Recebido - OK', '', ''),
(32, 11, 'CELULAR NOTE 11', 98766, 0, 0, '156 - gabriel', '30/04/2023', 'Recebido - OK', '', ''),
(33, 11, 'CELULAR NOTE 11', 98766, 0, 0, '156 - gabriel', '30/04/2023', 'AGUARDANDO SETOR', '', ''),
(34, 11, 'CELULAR NOTE 11', 98766, 3, 0, '456 JOSE PEDRO', '30/04/2023', 'Recebido - OK', '', ''),
(35, 11, 'CELULAR NOTE 11', 98766, 0, 0, '156 - gabriel', '30/04/2023', 'AGUARDANDO SETOR', '', ''),
(36, 11, 'CELULAR NOTE 11', 98766, 0, 0, '156 - gabriel', '30/04/2023', 'AGUARDANDO SETOR', '', ''),
(37, 11, 'CELULAR NOTE 11', 98766, 0, 0, '156 - gabriel', '30/04/2023', 'AGUARDANDO SETOR', '', ''),
(38, 11, 'CELULAR NOTE 11', 98766, 3, 0, '156 - gabriel', '17/05/2023', 'AGUARDANDO SETOR', '', '');

-- --------------------------------------------------------

--
-- Estrutura para tabela `solicitacao_suprimentos`
--

CREATE TABLE `solicitacao_suprimentos` (
  `id` int(11) NOT NULL,
  `nomeS` varchar(200) NOT NULL,
  `data` varchar(20) NOT NULL,
  `loja` int(11) NOT NULL,
  `status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `solicitacao_suprimentos`
--

INSERT INTO `solicitacao_suprimentos` (`id`, `nomeS`, `data`, `loja`, `status`) VALUES
(1, 'SACO DE LIXO', '19/04/2023', 11, 'Recebido - OK'),
(2, 'SACO DE LIXO', '19/04/2023', 11, 'Recebido - OK'),
(10, 'SACO DE LIXO', '19/04/2023', 11, 'AGUARDANDO SETOR'),
(11, 'SACO DE LIXO', '27/04/2023', 11, 'AGUARDANDO SETOR'),
(12, 'SACO DE LIXO', '29/04/2023', 11, 'AGUARDANDO SETOR'),
(13, 'SACO DE LIXO', '17/05/2023', 11, 'AGUARDANDO SETOR'),
(14, 'SACO DE LIXO', '17/05/2023', 11, 'AGUARDANDO SETOR');

-- --------------------------------------------------------

--
-- Estrutura para tabela `sugestion_produtos`
--

CREATE TABLE `sugestion_produtos` (
  `id` int(11) NOT NULL,
  `nome_p` varchar(500) NOT NULL,
  `data` varchar(20) NOT NULL,
  `nome` varchar(500) NOT NULL,
  `status` varchar(50) NOT NULL,
  `comentarios` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `sugestion_produtos`
--

INSERT INTO `sugestion_produtos` (`id`, `nome_p`, `data`, `nome`, `status`, `comentarios`) VALUES
(4, 'wef', '16/04/2023 10:36:05', 'wendell ', 'Pendente', ''),
(5, 'wef', '16/04/2023 10:36:05', 'wendell ', 'Pendente', ''),
(6, 'wef', '16/04/2023 10:36:05', 'wendell ', 'Pendente', ''),
(7, 'wef', '16/04/2023 10:36:05', 'wendell ', 'Pendente', ''),
(8, 'wef', '16/04/2023 10:36:05', 'wendell ', 'Pendente', ''),
(9, 'wef', '16/04/2023 10:36:05', 'wendell ', 'Pendente', ''),
(10, 'wef', '16/04/2023 10:36:05', 'wendell ', 'Pendente', ''),
(11, 'wef', '16/04/2023 10:36:05', 'wendell ', 'Pendente', ''),
(12, 'wef', '16/04/2023 10:36:05', 'wendell ', 'Pendente', ''),
(13, 'wef', '16/04/2023 10:36:05', 'wendell ', 'Pendente', ''),
(14, 'wef', '16/04/2023 10:36:05', 'wendell ', 'Pendente', ''),
(15, 'wef', '16/04/2023 10:36:05', 'wendell ', 'Pendente', ''),
(16, 'wef', '16/04/2023 10:36:05', 'wendell ', 'Pendente', ''),
(17, 'wef', '16/04/2023 10:36:05', 'wendell ', 'Pendente', ''),
(18, 'wef', '16/04/2023 10:36:05', 'wendell ', 'Pendente', ''),
(19, 'wef', '16/04/2023 10:36:05', 'wendell ', 'Pendente', ''),
(20, 'ssd m2', '16/04/2023', 'wendell ', 'Pendente', ''),
(21, '', '17/04/2023', '', 'Pendente', ''),
(22, 'shop9', '27/04/2023', 'vitor', 'Pendente', ''),
(23, 'GAMER X', '29/04/2023', 'we', 'Pendente', ''),
(24, 'wendell', '30/04/2023', 'web ', 'Pendente', '');

-- --------------------------------------------------------

--
-- Estrutura para tabela `suprimentos`
--

CREATE TABLE `suprimentos` (
  `id` int(10) NOT NULL,
  `nomeS` varchar(100) NOT NULL,
  `recepiente` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `suprimentos`
--

INSERT INTO `suprimentos` (`id`, `nomeS`, `recepiente`) VALUES
(1, 'SACO DE LIXO', 'nao');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tipos_os`
--

CREATE TABLE `tipos_os` (
  `id` int(11) NOT NULL,
  `produto` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `tipos_os`
--

INSERT INTO `tipos_os` (`id`, `produto`) VALUES
(1, 'Celular'),
(2, 'Notebook');

-- --------------------------------------------------------

--
-- Estrutura para tabela `vendedor`
--

CREATE TABLE `vendedor` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `numero` int(10) NOT NULL,
  `data` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `vendedor`
--

INSERT INTO `vendedor` (`id`, `nome`, `numero`, `data`) VALUES
(1, 'JOSE PEDRO', 456, '10/09/2025'),
(2, 'JOSE PEDRO ANDRADE', 650, '10/09/2025');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `avisos`
--
ALTER TABLE `avisos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `close`
--
ALTER TABLE `close`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `encomenda_clientes`
--
ALTER TABLE `encomenda_clientes`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `loja`
--
ALTER TABLE `loja`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `motoboy`
--
ALTER TABLE `motoboy`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `open`
--
ALTER TABLE `open`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `ordem_servico`
--
ALTER TABLE `ordem_servico`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `ouvidoria`
--
ALTER TABLE `ouvidoria`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `ranking`
--
ALTER TABLE `ranking`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `rota_motoboy`
--
ALTER TABLE `rota_motoboy`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `solicitacao_produtos`
--
ALTER TABLE `solicitacao_produtos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `solicitacao_suprimentos`
--
ALTER TABLE `solicitacao_suprimentos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `sugestion_produtos`
--
ALTER TABLE `sugestion_produtos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `suprimentos`
--
ALTER TABLE `suprimentos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `tipos_os`
--
ALTER TABLE `tipos_os`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `vendedor`
--
ALTER TABLE `vendedor`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `avisos`
--
ALTER TABLE `avisos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `close`
--
ALTER TABLE `close`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de tabela `encomenda_clientes`
--
ALTER TABLE `encomenda_clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de tabela `login`
--
ALTER TABLE `login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `loja`
--
ALTER TABLE `loja`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `motoboy`
--
ALTER TABLE `motoboy`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `open`
--
ALTER TABLE `open`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de tabela `ordem_servico`
--
ALTER TABLE `ordem_servico`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `ouvidoria`
--
ALTER TABLE `ouvidoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `produtos`
--
ALTER TABLE `produtos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `ranking`
--
ALTER TABLE `ranking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `rota_motoboy`
--
ALTER TABLE `rota_motoboy`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT de tabela `solicitacao_produtos`
--
ALTER TABLE `solicitacao_produtos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de tabela `solicitacao_suprimentos`
--
ALTER TABLE `solicitacao_suprimentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de tabela `sugestion_produtos`
--
ALTER TABLE `sugestion_produtos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de tabela `suprimentos`
--
ALTER TABLE `suprimentos`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `tipos_os`
--
ALTER TABLE `tipos_os`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `vendedor`
--
ALTER TABLE `vendedor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
