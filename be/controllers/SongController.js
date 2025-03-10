const { Song } = require("../models");
class SongController {

    static async addSong(req, res, next){
        try {
            if(!req.file) {
                throw {'name' : 'file', 'message' : 'File harus di input'}
            }

            const {title} = req.body;
            const filePath = `/uploads/${req.file.filename}`;
            const song = await Song.create({ title, filePath });
            res.status(201).json({ message: "Lagu berhasil diunggah", data: song });


        }catch(error) {
            next(error);
        }
    }

    static async readSong(req, res) {
        try {
            const songs = await Song.findAll();
            res.status(200).json({ songs: songs });
        } catch (error) {
            next(error);
        }
    }
};

module.exports = SongController;