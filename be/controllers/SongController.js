const { Song } = require("../models");
const fs = require("fs");
const path = require("path");


class SongController {

    static async addSong(req, res, next) {
        try {

            const { title, band } = req.body;
            const image = req.files['image'][0].path;
            const filePath = req.files['song'][0].path;

            const newSong = await Song.create({ title, band, image, filePath });
            res.status(201).json({ message: "Add Succes", data: newSong });


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
                throw { name: "not-found-song", message: "Lagu tidak ditemukan" };
            }

            const songFilePath = path.join(__dirname, "..", song.filePath);
            if (fs.existsSync(songFilePath)) {
                await fs.promises.unlink(songFilePath);
            } else {
                console.log( songFilePath);
            }

            const imageFilePath = path.join(__dirname, "..", song.image);

            if (imageFilePath && fs.existsSync(imageFilePath)) {
                await fs.promises.unlink(imageFilePath);
            
            } else if (imageFilePath) {
                console.log(imageFilePath);
            }

            await song.destroy();
            res.status(200).json({ message: "Delete Success" });

        } catch (error) {
            next(error);
        }
    }
};

module.exports = SongController;