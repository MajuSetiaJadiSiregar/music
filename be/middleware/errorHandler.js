function errorHandler (error, req, res, next)
{

    switch (error.name)
    {
        case `SequelizeValidationError`:
        case `SequelizeUniqueConstraintError`:
            return res.status(400).json({ message: error.errors[0].message });

        case 'file' : 
            return res.status(400).json({message : error.message});
        
        case 'not-found-song' :
            return res.status(404).json({message : error.message});

        case 'auth' :
                return res.status(404).json({message : 'Silahkan login terlebih dahulu'});
                
        case '401':
            return res.status(401).json({ message: `Error invalid username or password`});
    }
}

module.exports = errorHandler;