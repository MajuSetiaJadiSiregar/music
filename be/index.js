require("dotenv").config();
const express = require("express");
const cors = require("cors");
const multer = require("multer");
const path = require("path");
const fs = require("fs");
const { Song } = require("./models");

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));


app.use("/uploads", express.static("uploads"));

const storage = multer.diskStorage({
    destination: "./uploads",
    filename: (req, file, cb) => {
        cb(null, Date.now() + path.extname(file.originalname));
    },
});

const upload = multer({ storage });


app.post("/upload", upload.single("song"), async (req, res) => {
    try {
        if (!req.file) return res.status(400).json({ message: "File tidak ditemukan!" });

        const { title } = req.body;
        const filePath = `/uploads/${req.file.filename}`;

        const song = await Song.create({ title, filePath });

        res.status(201).json({ message: "Lagu berhasil diunggah", data: song });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});


app.get("/songs", async (req, res) => {
    try {
        const songs = await Song.findAll();
        res.status(200).json({ data: songs });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

app.get("/songs/:id", async (req, res) => {
    try {
        const song = await Song.findByPk(req.params.id);
        if (!song) return res.status(404).json({ message: "Lagu tidak ditemukan" });

        res.status(200).json({ data: song });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

app.delete("/songs/:id", async (req, res) => {
    try {
        const song = await Song.findByPk(req.params.id);
        if (!song) return res.status(404).json({ message: "Lagu tidak ditemukan" });

        fs.unlinkSync("." + song.filePath);
        await song.destroy();

        res.status(200).json({ message: "Lagu berhasil dihapus" });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
