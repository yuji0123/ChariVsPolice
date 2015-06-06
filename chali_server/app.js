var express = require('express');
var debug = require('debug')('policedb');
var mongoose = require('mongoose');

var app = express();

app.set('port', process.env.PORT || 3000);

// mongoose
var Schema = mongoose.Schema;
var LocationSchema = new Schema({
  id: Number,
  user_id: Number,
  locate: String,
  date: Date
});
mongoose.model('locations', LocationSchema);
mongoose.connect('mongodb://localhost/policedb');
var Locations = mongoose.model('locations');

// socket.io
var http = require('http').Server(app);
var io = require('socket.io')(http);
io.on('connection', function(socket) {
  socket.on('disconnect', function() {
    console.log('user disconnected');
  });

  socket.on('location init', function(data) {
    console.log('location init');

    Locations.find({}).limit(100).exec(function(err, data){
      socket.emit('location init', data);
    });
  });

  socket.on('location send', function(data) {
    console.log('location send');

    data.date = Date.parse(data.date);
    var location = new location(data);
    location.save(function(err, location) {
      if(err) return console.error(err);
      io.emit('location send', location);
    });
  });
});


http.listen(app.get('port'), function() {
  console.log('lisntening on *:' + http.address().port);
});
