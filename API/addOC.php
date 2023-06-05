<?php

include 'conn.php';

$nome = $_POST['nome'];
$loja = $_POST['loja'];
$data = $_POST['data'];
$obs = $_POST['obs'];
$luz = $_POST['luz'];
$ar = $_POST['ar'];
$celular = $_POST['celular'];
$caixa = $_POST['caixa'];
$pc = $_POST['computador'];
$tv = $_POST['tv'];




$conn->query("INSERT INTO open(nome,loja,data,obs,luz,ar,celular,caixa,computador,tv) values('".$nome."','".$loja."','".$data."'
,'".$obs."','".$luz."','".$ar."','".$celular."','".$caixa."','".$pc."','".$tv."')")
?>

