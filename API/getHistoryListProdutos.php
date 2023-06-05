<?php

include 'conn.php';

$loja = $_GET['loja'];



$sql = $conn->query("SELECT * FROM solicitacao_produtos WHERE loja = $loja  AND status != 'AGUARDANDO SETOR' ORDER BY data DESC");

$res =array();
while($row=$sql->fetch_assoc())

{
    $res[] = $row;
}

echo json_encode($res);


?>