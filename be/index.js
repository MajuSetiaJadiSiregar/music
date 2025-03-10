require("dotenv").config();
const express = require("express");
const cors = require("cors");
const songRoutes = require('./routes/SongRoutes');
const errorHandler = require("./middleware/errorHandler");

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));


app.use("/uploads", express.static("uploads"));

app.use('/uploads', songRoutes)



app.use(errorHandler);

app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
