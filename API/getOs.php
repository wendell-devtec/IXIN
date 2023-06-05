<?php

include 'conn.php';

$loja = $_GET['loja'];



$sql = $conn->query("SELECT * FROM ordem_servico WHERE loja = $loja  AND status != 'RETIRADO' ORDER BY data DESC ");

$res =array();
while($row=$sql->fetch_assoc())

{
    $res[] = $row;
}

echo json_encode($res);


?>