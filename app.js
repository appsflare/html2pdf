'use strict'

const Hapi = require('hapi')
const pdf = require('html-pdf')
const fs = require('fs')
const path = require('path')

const server = new Hapi.Server()
server.connection({ port: process.env.PORT || 8188 })

server.route({
  method: 'GET',
  path: '/',
  handler: function (request, reply) {
    reply('Hello, world!')
  }
})

server.route({
  method: 'POST',
  path: '/convert/htmltopdf',
  handler: function (request, reply) {
    let payload = request.payload

    pdf.create(payload.html, payload.config || {}).toStream(function (err, stream) {
      if (err) {
        console.error(err)
        reply('An error occurred while generating pdf!!')
        return
      }
      reply(stream)
    })

  }
})

server.route({
  method: 'GET',
  path: '/convert/htmltopdf',
  handler: function (request, reply) {
    let html = path.join(__dirname, '/static/index.html')

    fs.readFile(html, 'utf8', function (error, data) {
      pdf.create(data, {format: 'A4'}).toStream(function (err, stream) {
        if (err) {
          console.error(err)
          reply('An error occurred while generating pdf!!')
          return
        }
        reply(stream)
      })
    })

  }
})

server.start((err) => {

  if (err) {
    throw err
  }
  console.log('Server running at:', server.info.uri)
})
