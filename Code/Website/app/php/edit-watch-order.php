<?php
require_once('DBHandler.php');
$postdata = file_get_contents("php://input");
$request = json_decode($postdata);
$id = $request->id;
$desc = $request->desc;
$address = $request->address;
$lat = $request->lat;
$lng = $request->lng;
$connection = new DBHandler();
$result = $connection->editWatchOrder($id, $desc, $address, $lat, $lng);
//convert the response to a json object
die(json_encode($result));
