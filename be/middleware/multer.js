const multer = require("multer");
const path = require("path");


const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        if (file.fieldname === "image") {
            cb(null, "./uploads/images");
        } else if (file.fieldname === "song") {
            cb(null, "./uploads/music");
        } else {
            cb(new Error("Invalid field name"), false);
        }
    },
    filename: (req, file, cb) => {
        cb(null, Date.now() + path.extname(file.originalname));
    },
});

const fileFilter = (req, file, cb) => {
    const imageTypes = ["image/jpeg", "image/png", "image/gif"];
    const audioTypes = ["audio/mpeg", "audio/wav", "audio/ogg"];

    if (file.fieldname === "image" && !imageTypes.includes(file.mimetype)) {
        return cb(new Error("Only images (JPG, PNG, GIF) are allowed"), false);
    }

    if (file.fieldname === "song" && !audioTypes.includes(file.mimetype)) {
        return cb(new Error("Only audio files (MP3, WAV, OGG) are allowed"), false);
    }

    cb(null, true);
};


const upload = multer({
    storage,
    // fileFilter,
    limits: { fileSize: 10 * 1024 * 1024 },
});


const uploadFiles = upload.fields([
    { name: "image", maxCount: 1 },
    { name: "song", maxCount: 1 }
]);

module.exports = { uploadFiles };
