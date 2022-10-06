const express = require('express');
const User = require('../models/user');
const bcryptjs = require('bcryptjs');
const { json } = require('express');
const jwt = require('jsonwebtoken');
const auth = require('../middlewares/auth_md');


const authRouter =  express.Router();

//Register 

authRouter.post("/api/register", async (req, res) => {
    try {
      //get data from client
  
      //post data in database
  
      //return the data to the user

      const { name, email, password,phone, type } = req.body;
      const existingUser = await User.findOne({ email });
      if (existingUser) {
        return res.status(400).json({ msg: "user already exist!" });
      }
      const cryptedpwd = await bcryptjs.hash(password, 8);
  
    
  
      let user = new User({
        name,
        email,
        password:cryptedpwd,
        phone,
        type ,
        
      });
      user = await user.save();
      res.json(user);
    } catch (e) {
      res.status(500).json({
        error: e.message,
      });
    }
  });

  authRouter.post('/api/login',async(req,res)=>{
    try{
      const {email,password}= req.body;
      const user = await User.findOne({email});

      if(email==null){
        return res.status(400).json({msg:'email null!'});
      }
      if(!user){

        return res.status(400).json({msg:'email not exist!'});
      }
      const isMatch = await bcryptjs.compare(password,user.password);
      if(!isMatch){
        return res.status(400).json({msg:'wrong password'});
      }
      const token = jwt.sign({id: user._id,},"passwordKey");
    res.json({token, ...user._doc});
    }catch(e){
      res.status(500).json({error: e.message});
    }
    
  });


  //verfy user
authRouter.post('/tokenIsValid',async(req,res)=>{
    try{
      const token= req.header('x-auth-token');
      if(!token){
        return res.json(false);
      }
     const verified= jwt.verify(token,"passwordKey");
if(!verified){
  return res.json(false);
}
const user = await User.findById(verified.id);
if(!user){
  return res.json(false);
}
res.json(true);


    }catch(e){
res.status(500).json({error: e.message});
    }

  });

  //get user Data
  authRouter.get('/',auth,async(req,res)=>{
    const user =await User.findById(req.user);
    res.json({...user._doc, token:req.token});
  });

  //get user data from id
  authRouter.get('/user',auth,async(req,res)=>{
    try{
      const userId = req.header('userId');
      const token = 'token';
      const password='password';
      
      const user = await User.findById(userId);
      res.json({token:token,password:password,...user._doc,});
    }catch(e){
      res.status(500).json({error:e.message});
    }
  });

module.exports = authRouter;


