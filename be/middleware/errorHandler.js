function errorHandler (error, req, res, next)
{
    console.log(error);
    switch (error.name)
    {
        case `SequelizeValidationError`:
        case `SequelizeUniqueConstraintError`:
            return res.status(400).json({ message: error.errors[0].message });

        case 'file' : 
            return res.status(400).json({message : error.message});
    }
}

module.exports = errorHandler;