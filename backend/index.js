import express from "express";
import mysql from "mysql";
import cors from "cors";

const app = express()

const db = mysql.createConnection({
    host:"localhost",
    user:"root",
    password:"27940",
    database:"bank_data"
})

app.use(express.json())
app.use(cors())

app.get("/",(req,res)=>{
    res.json("This is the backend")
})

app.get("/customer", (req,res)=>{
    const q = "SELECT * FROM customer"
    db.query(q,(err,data)=>{
        if(err) return res.json(err)
        return res.json(data)
    })
})

app.get("/request", (req,res)=>{
    const q = "SELECT * FROM loan_request where is_approved = 0"
    db.query(q,(err,data)=>{
        if(err) return res.json(err)
        return res.json(data)
    })
})

app.post("/transaction", (req,res)=>{
    const q = "call make_online_transfer('from', 'to', 'amount') values (?)"
    const values = [1002734, 1234567, 2300.00]

    db.query(q,[values],(err,data)=>{
        if(err) return res.json(err)
        return res.json(data)
    })
})

app.listen(8600, ()=>{
    console.log("Connected to Backend!")
})

