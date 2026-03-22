<?php
$servername = "localhost";
$username = "u165132681_publico_user"; // Your MySQL username
$password = "Tavernpublico2025"; // Your MySQL password
$dbname = "u165132681_t_publico"; // The name of your database

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// NOTE: The closing ?>