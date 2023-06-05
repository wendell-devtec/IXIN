<?php

include 'conn.php';

$loja = $_GET['loja'];



$sql = $conn->query("SELECT * FROM solicitacao_suprimentos WHERE loja = $loja  AND status != 'Recebido - OK' ");

$res =array();
while($row=$sql->fetch_assoc())

{
    $res[] = $row;
}

echo json_encode($res);


?>