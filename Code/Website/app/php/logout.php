<?php
session_start();
session_destroy();
header("Location: ../../views/index.html");
exit();
?>