NProgress.configure
  showSpinner: true
  ease: 'ease'
  speed: 5



#$(document).on "page:fetch", ->
#  NProgress.start()
#$(document).on "page:change", ->
#  NProgress.done()
#$(document).on "page:restore", ->
#  NProgress.remove()
#$(document).on "page:load", ->
#  NProgress.remove()

#$(document).on "page:receive", ->
#  NProgress.remove()


# Show spinner while saving:
toggleSpinner = -> $("#spinner").toggle()
#$('#spinner').hide()

#$(document).on 'page:fetch',   ->
#  alert "Page is loaded"
#  $("#spinner").hide()

#$(document).on 'page:fetch',   -> $('#spinner').toggle()
#$(document).on 'page:restore', -> $('#spinner').toggle()
#$(document).on "page:change",  -> $('#spinner').toggle()


#$ -> $('form').submit -> $(@).find('#spinner').show()

$(document).on "page:change", ->
  $("#spinner").hide()
$(document).on "page:load", ->
  $("#spinner").hide()
$(document).on "page:fetch", ->
  $("#spinner").show()
$(document).on "page:restore", ->
  $("#spinner").hide() #
