<?php

include 'conn.php';
$nome = $_POST['nomeP'];
$loja = $_POST['loja'];
$date = $_POST['data'];
$seller = $_POST['vendedor'];
$status = $_POST['status'];
$sinal = $_POST['sinal'];
$valor_sinal = $_POST['valor_sinal'];
$obs = $_POST['obs'];

$conn->query("INSERT INTO encomenda_clientes(nomeP,loja,data,vendedor,status,sinal,valor_sinal,obs) values('".$nome."','".$loja."','".$date."','".$seller."','".$status."'
,'".$sinal."','".$valor_sinal."','".$obs."')")
?>

