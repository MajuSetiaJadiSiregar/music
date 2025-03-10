const { Song } = require("../models");
const fs = require("fs");


class SongController {

    static async addSong(req, res, next) {
        try {
            if (!req.file) {
                throw { 'name': 'file', 'message': 'File harus di input' }
            }

            const { title } = req.body;
            const filePath = `/uploads/${req.file.filename}`;
            const song = await Song.create({ title, filePath });
            res.status(201).json({ message: "Lagu berhasil diunggah", data: song });


        } catch (error) {
            next(error);
        }
    }

    static async readSong(req, res, next) {
        try {
            const songs = await Song.findAll();
            res.status(200).json({ songs: songs });
        } catch (error) {
            next(error);
        }
    }


    static async readSongById(req, res, next) {
        try {
            const song = await Song.findByPk(req.params.id);
            if (!song) {
                throw { 'name': 'not-found-song', 'message': 'Lagu not found' };
            }
            res.status(200).json({ song: song });
        } catch (error) {
            next(error);
        }
    }


    static async deleteSongById(req, res, next) {
        try {

            const song = await Song.findByPk(req.params.id);
            if (!song) {
                throw { 'name': 'not-found-song', 'message': 'Lagu not found' };
            }

            fs.unlinkSync("." + song.filePath);
            await song.destroy();
            res.status(200).json({ message: "Lagu berhasil dihapus" });

        } catch (error) {
            next(error);
        }
    }
};

module.exports = SongController;