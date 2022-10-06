const express = require('express');
const auth = require('../middlewares/auth_md');
const Post = require('../models/post');
const User = require('../models/user');
const { use } = require('./auth');
const postsRouter = express.Router();

//addPost

postsRouter.post('/api/upload-posts',auth,async(req,res)=>{
    try{
        const user = await User.findById(req.user);
        const type = user.type;
        const name = user.name;
        const {description,image,time}=req.body;
        let post = new Post({
            userId:req.user,
            description,
            name,
            image,
            type,
            time
        });

        post = await post.save();


        res.json(post);
    }catch(e){
        res.status(500).json({error:e.message});
    }
});



//get Posts
postsRouter.get('/api/get-posts',auth,async(req,res)=>{
    try{

        const user = await User.findById(req.user);
        const type = user.type;
        if(type!='Searcher'){
            const post = await Post.find({type:'Searcher'});
            return res.json(post);
        }

        const post = await Post.find({type:'Provider'});
        

        res.json(post);
    }catch(e){
        res.status(500).json({error:e.message});
    }
});

postsRouter.get('/api/posts/:description',auth,async(req,res)=>{
    try{

       
        const user = await User.findById(req.user);
        const type = user.type;
        if(type!='Searcher'){
            const post = await Post.find({description:{$regex:req.params.description,$options:"i"},type:'Searcher'});
            return res.json(post);
        }

        const post = await Post.find({description:{$regex:req.params.description,options:"i"},type:'Searcher'});
        

        res.json(post);
    }catch(e){
        res.status(500).json({error:e.message});
    }
});
module.exports = postsRouter;

