<?php

/**
 *
 * Projecto de Sistemas de Informação Distribuídos 2020
 * 
 * Grupo 23
 * 
 * Deteção de Intrusão e Incêndio em Museus
 *
 * @author Miguel Diaz Gonçalves 82493
 * @author Gonçalo Dias do Amaral 83380
 * @author André Freitas 82361
 * @author Pedro Jones 82946
 * @author Dmytro Astashov 74278
 * @author Vitor Manuel Figueira Canhão 73788
 * @version 0.21
 *
 * Migração em PHP
 *
 */

$host_source = 'localhost';
$host_target = 'localhost';
$db_source = 'main';
$db_target = 'log';
$user = 'system';
$password = 'password';

$GLOBALS['DEBUG']=true;

$conn_source = db_connect($host_source, $user, $password, $db_source);
$conn_target = db_connect($host_target, $user, $password, $db_target);

$tb_list = table_list($conn_target);

foreach ($tb_list as $table) {

    if ($GLOBALS['DEBUG']) echo "Copy from $db_source.$table to $db_target.$table" . PHP_EOL;
    $max_id = max_id($conn_target, $table);
    if ($GLOBALS['DEBUG']) echo "Query : SELECT * FROM $table WHERE ID > $max_id" . PHP_EOL;
    $result = mysqli_query($conn_source, "SELECT * FROM $table WHERE ID > $max_id");
    while ($row = mysqli_fetch_assoc($result)) {
        $sql = "INSERT INTO $table (" . implode(", ", array_keys($row)) . ") VALUES ('" . implode("', '", array_values($row)) . "');";
        if ($GLOBALS['DEBUG']) echo "Insert : $sql" . PHP_EOL;
        mysqli_query($conn_target, str_replace("''", "null", $sql));
    }
}

mysqli_free_result($result);

mysqli_close($conn_source);
mysqli_close($conn_target);


/**
 * 
 * Ligação a base de dados.
 * 
 */
function db_connect($host, $user, $password, $database)
{

    $connection = mysqli_connect($host, $user, $password);
    if (!$connection) {
        die("Could not connect to $host: " . mysqli_error($connection));
    }
    mysqli_select_db($connection, $database);
    return $connection;
}

/**
 * 
 * Max ID.
 * 
 * Retorna o ID do ultimo registo copiado
 * 
 */
function max_id($connection, $table)
{

    if (empty_table($connection, $table)) {
        $max_id = 0;
    } else {
        $result = mysqli_query($connection, "SELECT MAX(ID) AS max_id FROM $table");
        $row = mysqli_fetch_array($result);
        $max_id = $row['max_id'];
        mysqli_free_result($result);
    }
    return $max_id;
}

/**
 * 
 * Empty table.
 * 
 * Verifica se a tabela está vazia
 * 
 */
function empty_table($connection, $table)
{
    $result = mysqli_query($connection, "SELECT * FROM $table LIMIT 1");
    if (!$result) {
        die("Error: " . mysqli_error($connection));
    }
    return (mysqli_num_rows($result) > 0) ? false : true;
}

/**
 * 
 * Table list.
 * 
 * Gera uma lista das tabelas de log
 * 
 */
function table_list($connection)
{
    $table = array();
    $result = mysqli_query($connection, "SHOW TABLES");
    if (!$result) {
        die("Error: " . mysqli_error($connection));
    }    
    while ($tbl = mysqli_fetch_array($result)) {
        $table[] = $tbl[0];
        if ($GLOBALS['DEBUG']) echo "Table : $tbl[0]" . PHP_EOL;
    }
    return ($table);
}
