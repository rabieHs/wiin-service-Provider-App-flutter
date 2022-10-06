const mongoose = require('mongoose');
const worksSchema = mongoose.Schema({
    title:{
        type:String,
        required:true,
        trim:true
    },
    content:{
        type:String,
        required:true,
        trim:true
    },
    userId:{
        type:String,
        required:true,
        trim:true
    },
    images:[{
        type:String,
        required:true,
       }]
});
const Work = mongoose.model('Work',worksSchema);
module.exports = Work;