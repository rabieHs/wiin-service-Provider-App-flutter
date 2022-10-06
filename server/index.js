const express = require('express');
const mongoose = require('mongoose');
const authRouter = require('./routes/auth');
const postsRouter = require('./routes/posts');
const worksRouter = require('./routes/works');



const PORT = 3000;
const app = express();
const DB ="mongodb+srv://rabiehs:97152897@cluster0.id99ne2.mongodb.net/?retryWrites=true&w=majority";



app.use(express.json());
app.use(authRouter);
app.use(postsRouter);
app.use(worksRouter);



mongoose.connect(DB).then(()=>{
    console.log('connection successfull');
}).catch(e=>{
    console.log(e);
});

app.listen(PORT,'0.0.0.0',()=>{
    console.log(`connected at port ${PORT}`);
});
