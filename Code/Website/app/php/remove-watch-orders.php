<?php
require_once('DBHandler.php');
<<<<<<< HEAD
=======
$postdata = file_get_contents("php://input");
$request = json_decode($postdata);
>>>>>>> feature/246-add-watch-orders
$connection = new DBHandler();
$result = $connection->removeWatchOrders();
//convert the response to a json object
die(json_encode($result));
