<?php
$servername = "localhost";
$username = "xcispcjl_gaurav_saxena";
$password = "bU&IdB(cKYi?";
$dbname = "xcispcjl_gaurav_saxena";

// Create a connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check the connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Retrieve data from the Flutter app
$patient_name = $_POST['name']; 
$patient_address = $_POST['address'];
$phone = $_POST['phone'];
$dob = $_POST['dob'];
$age = $_POST['age'];
$sex = $_POST['sex'];

// Get the current date
$date = date("Y-m-d");  // Assuming your database date column is in the YYYY-MM-DD format

// Insert data into the database
$sql = "INSERT INTO patient_table (patient_name, patient_address, phone, age, sex, dob, date) VALUES ('$patient_name', '$patient_address', '$phone', '$age', '$sex', '$dob', '$date')";

if ($conn->query($sql) === TRUE) {
    echo "Record created successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

// Close the connection
$conn->close();
?>
