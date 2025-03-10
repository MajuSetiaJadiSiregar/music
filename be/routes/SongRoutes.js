const express = require('express');
const upload = require('../middleware/multer');
const SongController = require('../controllers/SongController');
const router = express.Router();

router.post('/', upload.single('song'), SongController.addSong);
router.get('/', SongController.readSong);

module.exports = router;