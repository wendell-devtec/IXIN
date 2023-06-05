<?php
date_default_timezone_set('America/Sao_Paulo');

include 'conn.php';

$data_atual = date("d/m/Y");


$sql = $conn->query("SELECT * FROM rota_motoboy WHERE (motoboy, dataS) IN (SELECT motoboy, MAX(dataS) FROM rota_motoboy GROUP BY motoboy) ORDER BY motoboy ASC, dataS DESC");


$res =array();
while($row=$sql->fetch_assoc())

{
    $res[] = $row;
}

echo json_encode($res);


?>