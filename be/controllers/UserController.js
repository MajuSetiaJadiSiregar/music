const { hashPassword, comparePassword } = require("../utils/bcrypt");
const { User } = require('../models');
const { signToken } = require("../utils/jwt");

class UserController {

    static async registerUser(req, res, next) {

        try {
            const { username, email, password } = req.body;
            let hashed = hashPassword(password);
            await User.create({ 
                username, 
                email, 
                password: hashed
            });
            res.status(201).json({message : 'Register Success'});
        } catch (error) {
            next(error);
        }
    }

    static async loginUser(req, res, next) {
        try {
            const { username, password } = req.body;
            if (!username || !password) {
                throw { name: '400' };
            }

            const user = await User.findOne({ where: { username } });

            if (!user) {
                throw { name: '401' };
            } 
            const validPassword = comparePassword(password, user.password);

            if (!validPassword) {
                throw { name: '401' };
            } 
            const accessToken = signToken({ id: user.id, role: user.role });
            res.status(200).json({ accessToken });

        } catch (error) {
            next(error);
        }
    }
};

module.exports = UserController;