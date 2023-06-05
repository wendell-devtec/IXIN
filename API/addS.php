<?php

include 'conn.php';
$nome = $_POST['nomeS'];
$loja = $_POST['loja'];
$data = $_POST['data'];
$status = $_POST['status'];

$conn->query("INSERT INTO solicitacao_suprimentos(nomeS,loja,data,status) values('".$nome."','".$loja."','".$data."','".$status."')")
?>

