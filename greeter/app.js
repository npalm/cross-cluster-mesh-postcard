const express = require('express')
const request = require('request')
const fs = require('fs')
const path = require('path')

const app = express()
const HOST = '0.0.0.0'
const PORT = process.env.PORT || 3000
const LOCATION = process.env.LOCATION || 'local'
const TIMEOUT = process.env.TIMEOUT || 3000
const page = fs.readFileSync(path.join(__dirname, 'index.html'), 'utf8')
console.log(page)

const SECOND_CLUSTER = process.env.SECOND_CLUSTER || 'http://localhost:3001'

app.get('/greeter', function (req, res) {
  request(
    {
      method: 'GET',
      url: SECOND_CLUSTER,
      timeout: TIMEOUT
    },

    function (error, response, body) {
      if (!error && response.statusCode == 200) {
        const html = page.replace('__VIA__', SECOND_CLUSTER).replace('__MESSAGE__', 'Hi there, <br<br> We have a message for you:<br><br>' + body).replace('__FROM__', LOCATION)
        res.send(html)
      } else {
        const html = page.replace('__VIA__', '').replace('__MESSAGE__', 'Hi there, <br><br>Oops we received nothing!').replace('__FROM__', LOCATION)
        res.send(html)
        console.log(error)
      }
    })
}).get('/', function (req, res) {
  res.send('ready')
})

app.listen(PORT, HOST)

console.log(`App listening on http://${HOST}:${PORT}!`)
console.log(`World service endpoint on ${SECOND_CLUSTER}`)
