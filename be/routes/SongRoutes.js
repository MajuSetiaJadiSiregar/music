const express = require('express');
const upload = require('../middleware/multer');
const SongController = require('../controllers/SongController');
const router = express.Router();


router.get('/', SongController.readSong);
router.get('/:id', SongController.readSongById);
router.delete('/:id', SongController.deleteSongById);

module.exports = router;