const jwt = require('jsonwebtoken');

const auth = async(req,res,next)=>{
    try{
        const token = req.header('x-auth-token');
        if(!token){
            res.status(401).json({msg:'no auth token'})
        }
        const verified =await jwt.verify(token,'passwordKey');
        if(!verified){
            res.status(401).json({msg:'token verification failed'});
        }
        req.user = verified.id;
        req.token = token;
        next();

    }catch(e){
        res.status(500).json({error:e.message});
    }
}
module.exports = auth;