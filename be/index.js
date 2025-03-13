require("dotenv").config();
const express = require("express");
const cors = require("cors");


const songRoutes = require('./routes/SongRoutes');
const userRoutes = require('./routes/UserRoutes');
const errorHandler = require("./middleware/errorHandler");
const SongController = require("./controllers/SongController");
const { uploadFiles } = require("./middleware/multer");
const authentication = require("./middleware/authenticate");

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));


app.use("/api/uploads", express.static("uploads"));

app.post('/api/uploads', authentication,(req, res, next) => {
    uploadFiles(req, res, (err) => {
        if (err) {
            err.name = "file";
            console.log(err);
            return next(err);
        }
        next();
    });
}, SongController.addSong);
app.use('/api/songs', songRoutes);
app.use('/api', userRoutes);

app.use(errorHandler);

app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
