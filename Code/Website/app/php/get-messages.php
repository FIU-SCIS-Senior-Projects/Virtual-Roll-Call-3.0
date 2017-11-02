<?php
session_start();
require_once('DBHandler.php');
$postdata = file_get_contents("php://input");
$request = json_decode($postdata);
$connection = new DBHandler();
$result = $connection->getMessages();

die(json_encode($result));