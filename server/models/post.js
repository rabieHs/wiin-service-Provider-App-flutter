const mongoose = require('mongoose');

const postSchema = mongoose.Schema({
    userId:{
        type:String,
        required:true
    },
    name:{
        type:String,
        required:true,
    },
    description:{
        type:String,
        required:true
    },
    image:{
        type:String,
        required:true
    },
    type:{
        type:String,
        required:true
    },
    time:{
        type:String,
        required:true
    }
});
const Post = mongoose.model('Post',postSchema);
module.exports = Post;
