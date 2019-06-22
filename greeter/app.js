const express = require('express')
const request = require('request')

const app = express()
const HOST = '0.0.0.0'
const PORT = process.env.PORT || 3000
const LOCATION = process.env.LOCATION || 'unknown'
const TIMEOUT = process.env.TIMEOUT || 3000

const WORLD_SERVICE_ENDPOINT = process.env.WORLD_SERVICE_ENDPOINT || 'http://localhost:3001'

app.get('/', function (req, res) {
  request(
    {
      method: 'GET',
      url: WORLD_SERVICE_ENDPOINT,
      timeout: TIMEOUT
    },

    function (error, response, body) {
      if (!error && response.statusCode == 200) {
        res.send('Hello ' + body + 'send via ' + LOCATION)
      } else {
        console.log(body)
        console.log(error)
        res.send('Oops, nothing received. Send via ' + LOCATION)
      }
    })
})

app.listen(PORT, HOST)

console.log(`App listening on http://${HOST}:${PORT}!`)
console.log(`World service endpoint on ${WORLD_SERVICE_ENDPOINT}`)
