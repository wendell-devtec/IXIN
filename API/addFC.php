<?php

include 'conn.php';

$loja = $_POST['loja'];
$nome = $_POST['nome'];
$luz = $_POST['luz'];
$data = $_POST['data'];
$ar = $_POST['ar'];
$cell = $_POST['cell'];
$pc = $_POST[ 'pc'];
$cx = $_POST['cx'];
$rt = $_POST['retaguarda'];
$obs = $_POST['obs'];




$conn->query("INSERT INTO close(loja,nome,luz,ar,data,cell,pc,cx,retaguarda,obs) values('".$loja."','".$nome."','".$luz."','".$ar."',
'".$data."','".$cell."','".$pc."','".$cx."','".$rt."','".$obs."')")
?>

