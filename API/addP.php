<?php

include 'conn.php';
$nome = $_POST['nomeP'];
$loja = $_POST['loja'];
$code = $_POST['code'];
$qtd = $_POST['qtd'];
$qtd_separed = $_POST['qtd_separed'];
$seller = $_POST['vendedor'];
$data = $_POST['data'];
$status = $_POST['status'];
$obs = $_POST['obs'];

$conn->query("INSERT INTO solicitacao_produtos(nomeP,loja,code,qtd,qtd_separed,vendedor,data,status,obs) values('".$nome."','".$loja."','".$code."','".$qtd."','".$qtd_separed."'
,'".$seller."','".$data."','".$status."','".$obs."')")
?>

