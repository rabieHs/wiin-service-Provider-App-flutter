const { json } = require('express');
const express = require('express');
const worksRouter = express.Router();
const auth = require('../middlewares/auth_md');
const Work = require('../models/works');

worksRouter.post('/api/upload-works',auth,async(req,res)=>{
   try{
    const{title,content,images,userId}= req.body;
    let works = new Work({
        title,
        content,
        images,
        userId
    });
    works = await works.save();
    res.json(works);
   }catch(e){
    res.status(500).json({error:e.message});
   }
});


worksRouter.get('/api/fetch-works/:userId',auth,async(req,res)=>{
    try{
        const userId = req.params.userId;
        console.log(userId);
        const works = await Work.find({userId});
        res.json(works);

    }catch(e){
        res.status(500).json({error:e.message});
    }
});

module.exports = worksRouter;