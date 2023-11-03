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

// Select data from the table in descending order of the OPD column
$sql = "SELECT * FROM patient_table ORDER BY OPD DESC";  // Assuming the column name is "OPD"

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $rows = array();
    while ($row = $result->fetch_assoc()) {
        $rows[] = $row;
    }

    // Set the Content-Type header to indicate JSON response
    header('Content-Type: application/json');
    
    echo json_encode($rows); // Return data as JSON
} else {
    echo "No records found";
}

// Close the connection
$conn->close();
?>
