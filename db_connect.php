<?php
define('DB_SERVER', 'localhost');
define('DB_USERNAME', 'u165132681_publico_user');
define('DB_PASSWORD', 'Tavernpublico2025');
define('DB_NAME', 'u165132681_t_publico');

// Attempt to connect to MySQL database
$link = mysqli_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD, DB_NAME);

// Check connection
if ($link === false) {
    die("ERROR: Could not connect. " . mysqli_connect_error());
}

// Set the charset to utf8mb4 for proper emoji and special character handling
mysqli_set_charset($link, "utf8mb4");

// NOTE: The closing ?>