const { User } = require('../models');
const { verifyToken } = require('../utils/jwt');

const authentication =  async (req, res, next) => {
    try {

        const bearerToken = req.headers.authorization;
        console.log(bearerToken)
        if (!bearerToken) {
            throw { name: 'auth' };
        }
        let token = bearerToken.split(' ')[1];

        let verifiedToken = verifyToken(token);

        if (!verifiedToken){
            throw { name: 'auth' };
        }
        
        let user = await User.findByPk(verifiedToken.id);
        
        if (!user){
            throw { name: 'auth'}
        }
        req.user = {id: user.id, role: user.role}
        next();
    } catch (error) {
        next(error);
    }
}

module.exports = authentication;