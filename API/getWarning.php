<?php
date_default_timezone_set('America/Sao_Paulo');

include 'conn.php';

$data_atual = date("d/m/Y");


$sql = $conn->query("SELECT * FROM avisos WHERE dataF >= '$data_atual'");


$res =array();
while($row=$sql->fetch_assoc())

{
    $res[] = $row;
}

echo json_encode($res);


?>