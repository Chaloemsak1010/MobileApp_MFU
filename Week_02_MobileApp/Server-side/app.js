// Dev: Mike016
// Author: Chaloemsak Arsung

const con = require('./db'); // IMPORT FILE db.js
const express = require('express');
const bcrypt = require('bcrypt');
const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Show expenses
app.post('/showExpenses', (req , res ) => {
    const {userId , showAll} = req.body;
    if(showAll){
        // res showall expenses.
        const sql = "SELECT item, paid , date FROM expenses WHERE user_id = ?";
        con.query(sql, [userId], function(err, results) {
            if(err) {
                return res.status(500).send("Database server error");
            }
            return res.json(results); // Automatically serializes the data to JSON           
        });
   
    } else {
        // res show expenses only Today.
        const today = new Date().toISOString().split('T')[0];
        const sql = "SELECT item, paid, date FROM expenses WHERE user_id = ? AND DATE(date) = ?";
        con.query(sql, [userId, today], function (err, results) {
            if (err) {
                console.error("Database error:", err); // Log the error
                return res.status(500).send("Database server error");
            }
            return res.json(results);
        });
    }

});

// Login
app.post('/login', (req, res) => {
    const {username, password} = req.body;
    const sql = "SELECT id, password FROM users WHERE username = ?";
    con.query(sql, [username], function(err, results) {
        if(err) {
            return res.status(500).send("Database server error");
        }
        if(results.length != 1) {
            return res.status(401).send("Wrong username");
        }
        // compare passwords
        bcrypt.compare(password, results[0].password, function(err, same) {
            if(err) {
                return res.status(500).send("Hashing error");
            }
            if(same) {
                // console.log("UserId = " , results[0].id);
                return res.status(200).json({"id": results[0].id});
            }
            return res.status(401).send("Wrong password");
        });
    })
});

// ---------- Server starts here ---------
const PORT = 3000;
app.listen(PORT, () => {
    console.log('Server is running at ' + PORT);
});

// Hash password generator (API)
// // for test postman:[Get] http://localhost:3000/password/1111
// app.get('/password/:pass', (req, res) => {
//     const password = req.params.pass;
//     bcrypt.hash(password, 10, function(err, hash) {
//         if(err) {
//             return res.status(500).send('Hashing error');
//         }
//         res.send(hash);
//     });
// });

// Registration api
// app.post('/registration', (req, res) => {
//     const { username, password } = req.body;

//     // Hash the password
//     bcrypt.hash(password, 10, function(err, hash) {
//         if (err) {
//             return res.status(500).send('Hashing error');
//         }

//         // Insert the new user into the database
//         const sql = "INSERT INTO users (username, password) VALUES (?, ?)";
//         con.query(sql, [username, hash], function(err, results) {
//             if (err) {
//                 return res.status(500).send("Database server error");
//             }

//             // Check if the insertion was successful
//             if (results.affectedRows === 1) {
//                 return res.status(200).send("Registration successful");
//             } else {
//                 return res.status(500).send("Registration failed");
//             }
//         });
//     });
// });


