const express = require('express');
const path = require('path');
const cors = require('cors');
const mysql = require('mysql2');
const { measureMemory } = require('vm');
// const mysql = require('mysql2/promise');



// Constants
const publicPath = path.join(__dirname, 'public');
const app = express();
const port = 4000;
const dbEndpoint = process.env.RDS_ENDPOINT;



// Middleware
app.use(express.static(publicPath));
app.use(express.urlencoded({ extended: true }));
app.use(cors());
app.use(express.json());

// Connect to MongoDB once on server startup
const connection = mysql.createConnection({
  host: dbEndpoint,  // <- Your RDS endpoint
  user: 'root',                                // <- Your DB username
  password: 'redhat',                     // <- Your DB password
  database: 'mysql',               // <- The DB you created
  port: 3306                                     // Default MySQL port
});

connection.connect((err) => {
  if (err) {
    return console.error('Error connecting: ' + err.stack);
  }
  console.log('Connected to RDS MySQL as ID ' + connection.threadId);
});

connection.query("CREATE DATABASE if not exists mydb", function (err, result) {
    if (err) throw err;
    console.log("Database created");
  });

    connection.query("USE mydb", function (err, result) { 
        if (err) throw err;
        console.log("Database switched");
        });

var sql = "CREATE TABLE IF NOT EXISTS customers (message VARCHAR(255))";
  connection.query(sql, function (err, result) {
    if (err) throw err;
    console.log("Table created");
  });

// Routes
app.get('/home', (req, res) => {
  res.send('Welcome to my page');
});

app.get('/fetch', async (req, res) => {
  try {
    const messages = await fetchData(); // Now fetchData returns a Promise ✅
    res.json({ messages });
  } catch (error) {
    console.error('Fetch error:', error);
    res.status(500).json({ error: 'Failed to fetch data' });
  }
});


app.get('/page',async (req, res) => {
  res.sendFile(path.join(__dirname, 'index.html'));
})


app.post('/submit', async (req, res) => {
  const { data } = req.body;

  if (!data) {
    return res.status(400).json({ error: 'No data received' });
  }
  try {
    await storeData(data);
    res.redirect('/page');
  } catch (error) {
    console.error('Error storing data:', error);
    res.status(500).json({ error: 'Failed to store data' });
  }
});

// Start the server
app.listen(port, () => {
  console.log(`Webserver is running on port: ${port}`);
});



// Function to store data in MongoDB
async function storeData(myvar) {
  try {
    const query = "INSERT INTO customers (message) VALUES (?)";
    const result = await connection.execute(query, [myvar]);

    console.log("Manually adding:", result.values);
  } catch (err) {
    console.error("Error inserting data:", err);
  }
}

function fetchData() {
  return new Promise((resolve, reject) => {
    connection.query("SELECT * FROM customers", function (err, result, fields) {
      if (err) {
        return reject(err);
      }
      console.log(result);
      resolve(result); // This will be returned to the route
    });
  });
}

