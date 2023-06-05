<?php

include 'conn.php';

$dataC = $_POST['dataC'];
$dataS = $_POST['dataS'];
$local_last = $_POST['local_last'];
$local_next = $_POST['local_next'];
$loja = $_POST['loja'];
$nome = $_POST['nome'];
$motoboy = $_POST['motoboy'];
$produtos = $_POST['produtos'];
$malote = $_POST['malote'];
$troco = $_POST['troco'];
$os = $_POST['os'];
$outros = $_POST['outros'];
$produtosL = $_POST['produtosL'];
$maloteL = $_POST['maloteL'];
$trocoL = $_POST['trocoL'];
$osL = $_POST['osL'];
$outrosL = $_POST['outrosL'];
$lat_now = $_POST['lat_now'];
$long_now = $_POST['long_now'];
$lat_next = $_POST['lat_next'];
$long_next = $_POST['long_next'];
$distancia = $_POST['distancia'];




$conn->query("INSERT INTO rota_motoboy(dataC,dataS,local_last, local_next,loja,nome,motoboy,produtos,malote,troco,os,outros,produtosL,maloteL,trocoL,osL,outrosL,lat_now,long_now,lat_next,long_next,distancia) values('".$dataC."','".$dataS."','".$local_last."','".$local_next."','".$loja."','".$nome."','".$motoboy."','".$produtos."','".$malote."','".$troco."','".$os."','".$outros."','".$produtosL."','".$maloteL."','".$trocoL."','".$osL."','".$outrosL."','".$lat_now."','".$long_now."','".$lat_next."','".$long_next."','".$distancia."')")
?>

